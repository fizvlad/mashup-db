require 'test_helper'

class MashupTest < ActiveSupport::TestCase
  test 'audio exist' do
    assert mashups(:new_year_miracle).audio
    assert mashups(:new_year_miracle).audio.artist
  end
end
