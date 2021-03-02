Rails.application.routes.draw do
  resources :tasks do
    member do
      put :state_update
    end
    collection do
      get :task_time
      get :priority_important
    end
  end
  root 'tasks#index'
end
