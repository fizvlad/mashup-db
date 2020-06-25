class Artist < ApplicationRecord
  validates :name, presence: true

  has_many :audios, dependent: :destroy
end
