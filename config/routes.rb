Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
  	get ":category_id", action: :index, on: :collection
  end
end
