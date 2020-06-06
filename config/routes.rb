Rails.application.routes.draw do

  root to: 'tests#index'

  devise_for :users,
              path: :gurus,
              path_names: { sign_in: :login, sign_out: :logout },
              controllers: { sessions: 'sessions' }
  devise_for :admins, path: :admin


  resources :tests, only: :index do
    post :start, on: :member
  end

  resources :feedback, only: [:index, :create]

  resources :test_passages, only: [:show, :update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: :true, except: :index do
        resources :answers, shallow: :true, except: :index
      end
    end
  end
  
end
