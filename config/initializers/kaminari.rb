# Avoid conflicts between Kaminari and will_paginate
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
