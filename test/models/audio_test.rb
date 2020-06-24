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
end
