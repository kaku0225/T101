Rails.application.routes.draw do
  root 'sessions#new'

  resource :users, controller: 'registrations', only:[:create, :edit, :update] do
    get '/sign_up', action: 'new'
  end

  resource :users, controller: 'sessions', only:[] do
    get '/sign_in', action: 'new'
    post '/sign_in', action: 'create'
    delete '/logout', action: 'destroy'
  end

  resource :users, only:[] do
    resources :tasks do
      member do
        put :state_update
      end
      collection do
        get :task_time
        get :priority_important
        get :find_state
      end
    end
  end
end
