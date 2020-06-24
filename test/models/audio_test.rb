require 'test_helper'

class AudioTest < ActiveSupport::TestCase
  test 'correct title validation' do
    assert audios(:buttercup).valid?
  end

  test 'empty name' do
    assert_not audios(:nameless).valid?
  end

  test 'mashup' do
    assert audios(:mystery_music).mashup
  end

  test 'checking where the audio is used' do
    assert audios(:get_got).mashups
    assert_not audios(:get_got).mashups.empty?
    assert audios(:get_got).mashups.include? mashups(:new_year_miracle)
  end
end
