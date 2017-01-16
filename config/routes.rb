Rails.application.routes.draw do
  root "static_pages#show", page: "home"
  get "/pages/*page", to: "static_pages#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: [:destroy]
  resources :user_courses, only: [:show, :index]

  namespace :supervisors do
    resources :courses
    resources :subjects
    resources :users
  end
end
