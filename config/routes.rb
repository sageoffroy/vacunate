Rails.application.routes.draw do

  resources :areas
  resources :people
  resources :localities
  resources :states
  devise_for :users

  root 'welcome#index'

  get '/tablero' => 'tablero#index'

  get '/list_group_state/:locality/:population_group/:state/:age_min' => 'tablero#list_group_state'

  post '/update_states' => 'tablero#update_states'

  get '/update_ages/:locality' => 'tablero#update_ages'

  get '/change_state/:state/:id' => 'tablero#change_state'

  post '/check_dni' => 'tablero#check_dni'

  post '/create_csv' => 'tablero#create_csv'
  post '/send_csv' => 'tablero#send_csv'

  post 'download_tab', to: "tablero#download_tab"
  post 'download_semicolon', to: "tablero#download_semicolon"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
