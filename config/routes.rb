Rails.application.routes.draw do
  
  resources :areas
  resources :people
  resources :localities
  devise_for :users

  root 'welcome#index'

  get '/tablero' => 'tablero#index'

  get '/priority_list/:id' => 'tablero#priority_list'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
