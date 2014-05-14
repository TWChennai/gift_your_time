GiftYourTime::Application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :events
  resources :comments, only: [:create, :destroy]
  match 'search' => 'search#index', via: [:get, :post]

  get 'gratitude' => 'gratitude#index'
  get 'receive_gift' => 'receive_gift#index'
end
