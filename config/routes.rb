Rails.application.routes.draw do
  devise_for :users
  mount Rswag::Ui::Engine => '/api-docs'
  root 'home#index'

  mount Locator::Api => '/'
end
