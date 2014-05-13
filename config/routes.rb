GiftYourTime::Application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :events
  resources :comments, only: [:create, :destroy]

  get 'gratitude' => 'gratitude#index'
  get 'receive_gift' => 'receive_gift#index'
end
