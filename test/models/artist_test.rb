require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test 'correct name validation' do
    artist = Artist.new(name: 'Ирина Аллегрова')
    assert artist.valid?
  end

  test 'empty name' do
    artist = Artist.new(name: '')
    assert_not artist.valid?
  end
end
