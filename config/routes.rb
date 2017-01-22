Rails.application.routes.draw do
  root "static_pages#show", page: "home"
  get "/pages/*page", to: "static_pages#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: [:index, :destroy]
  resources :courses, only: :index
  resources :user_courses, only: :show do
    resources :user_subjects, only: [:show, :update]
  end
  resources :user_tasks, only: :create

  namespace :supervisors do
    resources :courses do
      resources :course_subjects
    end
    resources :course_subjects
    resources :subjects
    resources :user_subjects
    resources :users
  end
end
