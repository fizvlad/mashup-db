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
            if request.get?
              flash.notice = 'Not yet'
              # TODO: Render form
              redirect_to back_or_index
            elsif request.post?
              # TODO: Run action and redirect
              flash.notice = 'Parsed posts'
              redirect_to back_or_index
            end
          end
        end
      end
    end
  end
end
