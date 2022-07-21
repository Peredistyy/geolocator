module Locator
  class Users < Grape::API
    resource :users do
      desc 'Auth'
      params do
        requires :email, type: String, desc: 'Email', documentation: { param_type: 'query' }
        requires :password, type: String, desc: 'Password', documentation: { param_type: 'query' }
      end
      post :auth do
        user = User.find_by!(email: params[:email])

        if user.valid_password?(params[:password])
          Token.new(user: user).tap { |t| t.save! }
        else
          error!({ status_code: 'not_valid_password' }, 404)
        end
      end
    end
  end
end