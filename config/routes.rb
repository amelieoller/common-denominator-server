Rails.application.routes.draw do
  resources :ratings
  resources :items
  resources :categories
  resources :user_friends
  resources :users
  resources :friendships
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
