class Artist < ApplicationRecord
  validates :name, presence: true

  has_many :audios, dependent: :destroy

  def mashups
    Mashup.joins(:audio).where('audios.artist_id = ?', id)
  end

  def self.search(query)
    self.where('name LIKE ?', "%#{sanitize_sql_like(query)}%")
  end
end
