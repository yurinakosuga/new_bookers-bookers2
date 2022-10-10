Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  get "/home/about" => "homes#about", as: "about"
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  
end
