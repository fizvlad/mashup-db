require 'test_helper'

class AudioTest < ActiveSupport::TestCase
  test 'correct title validation' do
    audio = Audio.new(title: 'Sample title', artist: Artist.first)
    assert audio.valid?
  end

  test 'empty name' do
    audio = Audio.new(title: '', artist: Artist.first)
    assert_not audio.valid?
  end

  test 'missing artist' do
    audio = Audio.new(title: 'Sample text')
    assert_not audio.valid?
  end
end
