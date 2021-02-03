Rails.application.routes.draw do
  
  resources :people
  resources :localities
  devise_for :users

  root 'welcome#index'

  get '/tablero' => 'tablero#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
