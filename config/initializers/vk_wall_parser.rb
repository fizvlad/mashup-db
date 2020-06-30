require 'vk_wall_parser'

::VkWallParserRepeater = VkWallParser::Repeater.new(
  proc { Rails.application.credentials.dig(:vk, :api_key) },
  interval: 2.hours,
  extended_parsing_once_in: 4
)

VkWallParserRepeater.run
