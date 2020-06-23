require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test 'correct name validation' do
    assert artists(:jack_stauber).valid?
  end

  test 'empty name' do
    assert_not artists(:noname).valid?
  end
end
