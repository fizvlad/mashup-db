require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'validation' do
    assert posts(:one).valid?
    assert posts(:two).valid?
    assert posts(:three).valid?
  end
end
