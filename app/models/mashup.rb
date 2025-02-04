class Mashup < ApplicationRecord
  # NOTE: it is possible to use inheritance of Mashup from Audio, but I would
  #   like to do it in simplier way and just explicitly store ID of track

  # NOTE: be careful using #audio and #audios. First method returnes mashup
  #   itself, while second method returnes list of its sources. Prefer using
  #   #track and #sources instead.

  belongs_to :audio
  alias_attribute :track, :audio

  has_and_belongs_to_many :audios
  alias_attribute :sources, :audios

  has_and_belongs_to_many :posts

  def name
    "#{artist.name} - #{audio.title}"
  end

  delegate :artist, to: :audio

  def first_post
    posts.order(date: :asc).first
  end

  delegate :date, to: :first_post

  def related_user_ids
    re = posts.map(&:from_user)
    re.compact!
    re.uniq!
    re
  end

  def related_club_ids
    re = posts.map(&:from_club)
    re.compact!
    re.uniq!
    re
  end

  def self.search(query)
    joins(audio: :artist)
      .where('audios.title LIKE :q OR artists.name LIKE :q', { q: "%#{sanitize_sql_like(query)}%" })
  end

  def self.order_by_first_post_date
    joins(:posts)
      .select('mashups.*, MIN(posts.date) AS first_post_date')
      .group('mashups.id')
      .order('first_post_date DESC')
  end
end
