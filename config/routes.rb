Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :index, :create, :show]
  resources :goals
  resource :session, only: [:new, :create, :destroy]
  resources :goal_comments, only: [:create, :destroy]
  resources :user_comments, only: [:create, :destroy]
end
