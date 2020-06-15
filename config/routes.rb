Rails.application.routes.draw do
  
  devise_for :users, controllers: { confirmations: 'confirmations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end 

  root to: 'phrases#index' 
  
  resources :users, only: [:show, :index]
  
  resources :phrases do
    member do
      post :vote
    end
    resources :examples, only: [:create, :destroy] do
      post :vote
    end
  end 

  resources :notifications, only: :index do
    collection do
      put :read_all
    end
  end
  
  get 'static_pages/hello'=> 'static_pages#hello'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
