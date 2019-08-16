Rails.application.routes.draw do
  get 'persons/profile'
  devise_for :admins
  devise_for :users, controllers: { registrations: "registrations"}
  as :user do
    get '/' => 'devise/registrations#new'
  end

  mount ActionCable.server => "/cable"

  root 'static_pages#home'
  get 'home' => 'static_pages#home'
  get 'about' => 'static_pages#about'

  resources :tasks
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
