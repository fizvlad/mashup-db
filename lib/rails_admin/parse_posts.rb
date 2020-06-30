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

              api_key = Rails.application.credentials.dig(:vk, :api_key)
              if api_key
                data = VkWallParser.wall_get_until(api_key, **parameters)
                thr = Thread.new do
                  Rails.logger.info "Parsing #{data.size} posts"
                  posts = VkWallParser.parse_posts(data)
                  Rails.logger.info "Parsed #{data.size} posts"
                end
                thr.name = 'wall_parsing'
                flash.notice = "Started parsing #{data.size} posts in separate thread"
              else
                flash.alert = "Can not retrieve VK credentials!"
              end
            elsif request.get?
              @maximum_post_id = Post.maximum('id')
            end
            render @action.template_name
          end
        end
      end
    end
  end
end
