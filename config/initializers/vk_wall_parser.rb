require 'vk_wall_parser'

::VkWallParserRepeater = VkWallParser::Repeater.new(
  proc { Rails.application.credentials.dig(:vk, :api_key) || ENV['VK_API_KEY'] },
  interval: 2.hours,
  extended_parsing_once_in: 4
)

Rails.configuration.after_initialize do
  VkWallParserRepeater.run
end
