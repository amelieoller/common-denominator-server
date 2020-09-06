Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/auth", to: "auth#create"
      get "/current_user", to: "auth#show"

      get "/friendships/get_results/:id", to: "friendships#get_result_for_category"

      resources :user_friends
      resources :users, only: [:create]
      resources :friendships
      resources :ratings

      resources :categories do
        resources :items
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
