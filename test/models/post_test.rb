require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'validation' do
    assert posts(:sourceless).valid?
    assert posts(:deodorant_son).valid?
    assert posts(:shrek_miami).valid?
  end

  test 'posts-mashups association' do
    assert_equal 1, posts(:deodorant_son).mashups.size
    assert posts(:deodorant_son).mashups.include?(mashups(:deodorant_son))

    assert_equal 1, posts(:shrek_miami).mashups.size
    assert posts(:shrek_miami).mashups.include?(mashups(:shrek_miami))
  end

  test 'statistics' do
    assert posts(:shrek_miami).likes >= 0
    assert posts(:shrek_miami).reposts >= 0
    assert posts(:shrek_miami).views >= 0
    assert posts(:shrek_miami).comments >= 0
  end
end
