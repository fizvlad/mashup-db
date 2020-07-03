class Artist < ApplicationRecord
  validates :name, presence: true

  has_many :audios, dependent: :destroy

  def mashups
    Mashup.joins(:audio).where('audios.artist_id = ?', id)
  end

  def mashuper?
    mashups.any?
  end

  def posts
    Post.joins(mashups: :audio).where('audios.artist_id = ?', id)
  end

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

  def total_likes
    posts.sum(&:likes)
  end

  def total_reposts
    posts.sum(&:reposts)
  end

  def total_comments
    posts.sum(&:comments)
  end

  def total_views
    posts.sum(&:views)
  end

  def self.search(query)
    where('name LIKE ?', "%#{sanitize_sql_like(query)}%")
  end

  def self.order_by_audios_count
    joins(:audios)
      .select('artists.*, COUNT(artists.id) AS audios_count')
      .group('artists.id')
      .order('audios_count DESC')
  end
end
