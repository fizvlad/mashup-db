class Audio < ApplicationRecord
  validates :title, presence: true
  validates :artist_id, presence: true

  has_one :artist
end
