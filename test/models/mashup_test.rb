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

  test 'posts-mashups association' do
    assert_equal 1, mashups(:deodorant_son).posts.size
    assert mashups(:deodorant_son).posts.include?(posts(:deodorant_son))

    assert_equal 1, mashups(:shrek_miami).posts.size
    assert mashups(:shrek_miami).posts.include?(posts(:shrek_miami))
  end
end
