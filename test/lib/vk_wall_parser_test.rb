require 'vk_wall_parser'

class VkWallParserTest < ActiveSupport::TestCase
  def setup
    @api_key = Rails.application.credentials[:vk][:api_key]

    # NOTE: First post received from VK might be an old pinned one
    @recent_posts = VkWallParser.wall_get_until(@api_key, max_requests: 1, count: 10)
  end

  test 'wall requesting' do
    re = VkWallParser.wall_get(@api_key, offset: 0, count: 10)

    assert_instance_of Hash, re
    assert re[:count]
    assert re[:items]
    assert_equal 10, re[:items].size
  end

  test 'limited wall parsing #1' do
    re = VkWallParser.wall_get_until(@api_key, max_requests: 5, count: 100)

    assert_instance_of Array, re
    assert_equal 500, re.size
  end

  test 'limited wall parsing #2' do
    re = VkWallParser.wall_get_until(@api_key, max_requests: 5, count: 20)

    assert_instance_of Array, re
    assert_equal 100, re.size
  end

  test 'parsing until given id' do
    last_id = @recent_posts.last[:id]
    re = VkWallParser.wall_get_until(@api_key, until_id: @recent_posts.last[:id])

    assert_instance_of Array, re
    assert_equal last_id, re.last[:id]
  end

  test 'parsing with_offset' do
    offset = 5
    last_id = @recent_posts.last[:id]
    re = VkWallParser.wall_get_until(@api_key, offset: offset, until_id: last_id)

    assert_instance_of Array, re
    assert_equal @recent_posts.size - offset, re.size
  end

  test 'parsing to Post object' do
    posts = VkWallParser.parse_posts(@recent_posts)
    assert_instance_of Array, posts
    assert_equal @recent_posts.size, posts.size
    posts.each { |post| assert_instance_of Post, post }
  end
end
