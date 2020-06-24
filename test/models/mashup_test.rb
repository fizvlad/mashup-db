require 'test_helper'

class MashupTest < ActiveSupport::TestCase
  test 'audio exist' do
    assert mashups(:new_year_miracle).track
    assert mashups(:new_year_miracle).track.artist
  end

  test 'sources' do
    assert mashups(:mystery_music).sources
    assert_equal 2, mashups(:mystery_music).sources.size
    assert mashups(:mystery_music).sources.include? audios(:fc_why)
    assert mashups(:mystery_music).sources.include? audios(:fool_village_ost)
  end
end
