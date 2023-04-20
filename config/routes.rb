Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  # devise_for :users
  namespace :api do
    get 'profile' => "users#show"
    post 'register' => "users#create"
    post "login"  => "session#create"
    delete "logout" => "session#destroy"
    resources :movies
  end
end
