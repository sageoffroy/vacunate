Rails.application.routes.draw do
  
  resources :areas
  resources :people
  resources :localities
  resources :states
  devise_for :users

  root 'welcome#index'

  get '/tablero' => 'tablero#index'

  get '/list_group_state/:locality/:population_group/:state' => 'tablero#list_group_state'

  post '/update_states' => 'tablero#update_states'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
