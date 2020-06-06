Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end 

  root to: 'phrases#index' 
  
  resources :users, only: [:show, :index]
  resources :phrases do
    resources :examples, only: [:create, :destroy]
  end 
  
  get 'static_pages/hello'=> 'static_pages#hello'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
