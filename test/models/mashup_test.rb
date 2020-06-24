require 'test_helper'

class MashupTest < ActiveSupport::TestCase
  test 'audio exist' do
    assert mashups(:new_year_miracle).track
    assert mashups(:new_year_miracle).track.artist
  end
end
