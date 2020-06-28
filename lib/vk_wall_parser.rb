require 'net/http'
require 'json'

# Module to parse posts into the models.
module VkWallParser
  # Used version of VK API.
  API_VERSION = '5.110'.freeze

  # ID of #mashup club.
  OWNER_ID = -39_786_657

  # @return [URI]
  def self.method_uri(method_name, **opts)
    URI("https://api.vk.com/method/#{method_name}?#{URI.encode_www_form(opts)}")
  end

  # @return [Hash]
  def self.request(token, method_name, **opts)
    uri = method_uri(method_name, access_token: token, v: API_VERSION, **opts)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body, symbolize_names: true)
  end

  # @return [Array<Hash>]
  def self.wall_get(token, **opts)
    data = request(token, 'wall.get', owner_id: OWNER_ID, filter: 'owner', **opts)
    raise data.inspect unless data[:error].nil?

    data[:response]
  end

  # @return [Array<Hash>]
  def self.wall_get_until(token, until_id: 1, offset: 0, max_requests: 20, count: 100)
    total_count = offset + count + 1
    arr = []
    max_requests.times do |i|
      current_offset = offset + i * count
      break if current_offset >= total_count

      data = wall_get(token, offset: current_offset, count: count)

      raise data.inspect unless data[:error].nil?

      total_count = data[:count]

      break if data[:items].empty?

      # NOTE: Following line can be optimized, since data is sorted by id
      data[:items].select! { |item| item[:id] >= until_id }
      arr.concat(data[:items])

      break if data[:items].last[:id] <= until_id
    end
    arr
  end

  # @return [Array<Post>]
  def self.parse_posts(arr, timeout: 0)
    re = arr.map do |data|
      next nil if data[:marked_as_ads] != 0 # Not parsing ads
      parse_post(data)
      sleep timeout
    rescue StandardError => e
      Rails.logger.warn "Unable to parse post #{a}: \n#{e.full_message}"
    end
    re.compact!
    re
  end

  # @param data [Hash]
  # @return [Post]
  def self.parse_post(data)
    audios = get_audios_data(data)

    from_club = get_source_club(data)
    from_user = get_source_user(data)

    post = Post.find_or_create_by!(id: data[:id])
    post.update(
      from_club: from_club,
      from_user: from_user,
      likes: data[:likes][:count],
      reposts: data[:reposts][:count],
      views: data[:views][:count],
      comments: data[:comments][:count]
    )

    audios.each do |a|
      artist = Artist.find_or_create_by!(name: a[:artist])
      audio = Audio.find_or_create_by!(artist_id: artist.id, title: a[:title])
      mashup = Mashup.find_or_create_by!(audio_id: audio.id)

      post.mashups << mashup unless post.mashup_ids.include?(mashup.id)
    rescue StandardError => e
      Rails.logger.warn "Unable to save audio #{a}: \n#{e.full_message}"
    end

    post
  end

  # @param post [Hash]
  # @return [Array<Hash>]
  def self.get_audios_data(post)
    audios = []
    if post[:copy_history]
      # Recursively call for repost
      audios.concat get_audios_data(post[:copy_history].first)
    elsif post[:attachments]
      post[:attachments].each { |a| audios << a[:audio] if a[:type] == 'audio' }
    end
    audios
  end

  # @param post [Hash]
  # @return [Integer, nil]
  def self.get_source_club(post)
    if post[:copy_history]
      # If repost, handle original
      get_source_club(post[:copy_history].first)
    elsif post[:copyright] && post[:copyright][:id] && post[:copyright][:id].negative?
      # If with source field AND source is a group - ID of the group
      post[:copyright][:id]
    elsif post[:from_id] != OWNER_ID && post[:from_id].negative?
      # If posted by some group (not #mashup) - ID of the group
      post[:from_id]
    end
  end

  # @param post [Hash]
  # @return [Integer, nil]
  def self.get_source_user(post)
    if post[:copy_history]
      # If repost, handle original
      get_source_user(post[:copy_history].first)
    elsif post[:copyright] && post[:copyright][:id] && post[:copyright][:id].positive?
      # If with source field AND source is a user - ID of the group
      post[:copyright][:id]
    elsif post[:signer_id]
      # If post got a signer - use their ID
      post[:signer_id]
    elsif post[:from_id].positive?
      # If posted by user on wall - use their ID
      post[:from_id]
    end
  end
end
