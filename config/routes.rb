Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  get "/search" => "search#index", :as => "search"
end
