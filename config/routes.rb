GiftYourTime::Application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'events' => 'events#index'
  get 'gratitude' => 'gratitude#index'
  get 'receive_gift' => 'receive_gift#index'
  post 'event/:user_id' => "events#create", as: :create


end
