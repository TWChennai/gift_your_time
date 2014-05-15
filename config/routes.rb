GiftYourTime::Application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :events, :event_participation
  resources :comments, only: [:create, :destroy]
  get 'search' => 'search#index'

  get 'gratitude' => 'gratitude#index'
  get 'receive_gift' => 'receive_gift#index'
end
