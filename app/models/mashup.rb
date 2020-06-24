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
end
