Rails.application.routes.draw do
  devise_for :users
  root to: 'post_images#index'
  get 'search' => 'post_images#search'
  resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
