Rails.application.routes.draw do
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

end
