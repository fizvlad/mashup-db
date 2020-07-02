module ApplicationHelper
  def vk_posts_url(post_id)
    "https://vk.com/wall-39786657_#{post_id}"
  end

  def vk_profile_url(id)
    id.positive? ? "https://vk.com/id#{id}" : "https://vk.com/club#{id.abs}"
  end
end
