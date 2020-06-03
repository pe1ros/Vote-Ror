Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end 

  root to: 'phrases#index' 
  
  resources :phrases, only: [:new, :create, :edit, :update, :destroy] 
  
  get 'phrases/:id' => 'phrases#destroy'
  get 'static_pages/hello'=> 'static_pages#hello'
  resources :users, only: [:show, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
