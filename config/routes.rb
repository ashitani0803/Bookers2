Rails.application.routes.draw do

  root 'users#home'
  get '/home/about' => 'users#about'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
  	member do
  		get :following, :followers
  	end
  end
  resources :books do
  	resources :book_comments, only: [:create, :edit, :update, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
