module Extension
  module Authenticate
    def self.included(base)
      base.class_eval do
        helpers do
          def current_user
            @current_user ||= Token.find_by(token: params[:token])&.user
          end

          def authenticate!
            error!('Unauthorized', 401) unless current_user
          end
        end
      end
    end
  end
end
