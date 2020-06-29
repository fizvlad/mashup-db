require 'vk_wall_parser'

::VkWallParserRepeater = VkWallParser::Repeater.new(
  Rails.application.credentials[:vk][:api_key],
  interval: 15.minutes,
  extended_parsing_once_in: 4
)

VkWallParserRepeater.run
