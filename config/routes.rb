Rails.application.routes.draw do
  resources :tasks do
    member do
      put :state_update
    end
  end
  root 'tasks#index'
end
