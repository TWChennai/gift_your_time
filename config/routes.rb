GiftYourTime::Application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :events, only: [:index, :new, :create]

  get 'gratitude' => 'gratitude#index'
  get 'receive_gift' => 'receive_gift#index'
end
