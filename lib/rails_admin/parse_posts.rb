require 'vk_wall_parser'

module RailsAdmin
  module Config
    module Actions
      class ParsePosts < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :visible? do
          bindings[:abstract_model].model_name == 'Post'
        end

        register_instance_option :http_methods do
          %i[get post]
        end

        register_instance_option :pjax? do
          false
        end

        register_instance_option :link_icon do
          'fa fa-cloud-download'
        end

        register_instance_option :controller do
          proc do
            if request.post?
              parameters = params.require('parse_posts')
                                 .permit(%w[offset until_id max_requests count])
              parameters = parameters.to_hash
              parameters.symbolize_keys!
              parameters.transform_values!(&:to_i)

              data = VkWallParser.wall_get_until(Rails.application.credentials[:vk][:api_key],
                                                 **parameters)
              @posts = VkWallParser.parse_posts(data)
            end

            render @action.template_name
          end
        end
      end
    end
  end
end
