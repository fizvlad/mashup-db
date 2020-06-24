require 'net/http'
require 'json'

module VkWallParser
  API_VERSION = '5.110'

  OWNER_ID = -39786657

  def self.method_uri(method_name, **opts)
    URI("https://api.vk.com/method/#{method_name}?#{URI.encode_www_form(opts)}")
  end

  def self.request(token, method_name, **opts)
    uri = self.method_uri(method_name, access_token: token, v: API_VERSION, **opts)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.wall_get(token, **opts)
    data = self.request(token, 'wall.get', owner_id: OWNER_ID, filter: 'owner', **opts)
    raise data.inspect unless data[:error].nil?

    data[:response]
  end

  def self.wall_get_until(token, until_id: 1, offset: 0, max_requests: 20, count: 100)
    total_count = count + 1
    arr = []
    max_requests.times do |i|
      current_offset = offset + i * count
      break if current_offset >= total_count

      data = self.wall_get(token, offset: current_offset, count: count)

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

  def self.parse_posts!(arr)
    arr.map! do |post|
      next nil if post[:marked_as_ads] != 0 # Not parsing adds

      audios = self.get_audios_data(post)

      # TODO: Handle audios data

      from_club = self.get_source_club(post)
      from_user = self.get_source_user(post)

      Post.new(id: post[:id], from_club: from_club, from_user: from_user)
    end
    arr.compact!
    arr
  end

  def self.parse_posts(arr)
    dupped = arr.dup
    self.parse_posts!(dupped)
    dupped
  end

  private

  def self.get_audios_data(post)
    audios = []
    if post[:copy_history]
      # Recursively call for repost
      audios.concat self.get_audios_data(post[:copy_history].first)
    elsif post[:attachments]
      post[:attachments].each { |a| audios << a[:audio] if a[:type] == 'audio' }
    end
    audios
  end

  def self.get_source_club(post)
    if post[:copy_history]
      # Recursively call for repost
      self.get_source_club(post[:copy_history].first)
    elsif post[:copyright] && post[:copyright][:id] < 0 # NOTE: Group ID must be less than zero
      post[:copyright][:id]
    end
  end

  def self.get_source_user(post)
    if post[:copy_history]
      # Recursively call for repost
      self.get_source_user(post[:copy_history].first)
    elsif post[:signer_id]
      post[:signer_id]
    elsif post[:copyright] && post[:copyright][:id] > 0 # NOTE: User ID must be greater than zero
      post[:copyright][:id]
    end
  end
end
