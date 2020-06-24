class Mashup < ApplicationRecord
  belongs_to :audio

  # NOTE: it is possible to use inheritance of Mashup from Audio, but I would
  #   like to do it in simplier way and just explicitly store ID of track
end
