class Audio < ApplicationRecord
  validates :title, presence: true
  validates :artist_id, presence: true

  belongs_to :artist

  def name
    "#{artist.name} - #{title}"
  end

  # @return [Mashup, nil] mashup if this audio is a mashup or nil.
  def mashup
    @mashup ||= Mashup.find_by(audio_id: id)
  end

  has_and_belongs_to_many :mashups
end
