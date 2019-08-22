Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }

  # get "user_sign_in" => "users/sessions/registrations_controller#new", :as => "user_sign_in"
  # get "user_sign_out" => "users/sessions/registrations_controller#destroy", :as => "user_sign_out"
  # get "user_sign_up" => "users/registrations_controller#new", :as => "user_sign_up"

  mount ActionCable.server => "/cable"

  get '/' => 'static_pages#home'
  get 'home' => 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'dashboard' => 'static_pages#dashboard'
  root 'static_pages#home'

  resources :tasks
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
