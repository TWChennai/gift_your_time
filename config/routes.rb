GiftYourTime::Application.routes.draw do
  devise_for :users
  root to: 'events#index'
  resources :events, :event_participation
  resources :comments, only: [:create, :destroy]
  get 'search' => 'search#index'
end
