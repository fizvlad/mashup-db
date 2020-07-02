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

  def self.search(query)
    self.where('name LIKE ?', "%#{sanitize_sql_like(query)}%")
  end
end
