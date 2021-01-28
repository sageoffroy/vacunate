Rails.application.routes.draw do
  
  resources :people
  resources :pathologies
  resources :population_groups
  resources :localities
  resources :states
  get 'inscripcion' => 'inscripcion#index'
  
  devise_for :users

  root 'welcome#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
