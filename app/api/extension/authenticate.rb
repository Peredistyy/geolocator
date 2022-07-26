module Extension
  module Authenticate
    def self.included(base)
      base.class_eval do
        def self.auth_headers
          {
            'Auth-Token' => { description: 'Token', required: true }
          }
        end

        helpers do
          def current_user
            @current_user ||= Token.find_by(token: headers['Auth-Token'])&.user
          end

          def authenticate!
            error!('Unauthorized', 401) unless current_user
          end
        end
      end
    end
  end
end
