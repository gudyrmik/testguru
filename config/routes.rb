Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'tests#index'
  
  resources :tests do
    resources :questions, shallow: :true, except: :index do
      resources :answers, shallow: :true, except: :index
    end

    post :start, on: :member
  end

  resources :test_passages, only: [:show, :update] do
    get :result, on: :member
  end

  get :signup, to: 'users#new'
  resources :users, only: :create

  get :login, to: 'sessions#new'
  get :logout, to: 'sessions#destroy'
  resources :sessions, only: [:create, :destroy]

end
