Rails.application.routes.draw do
  
  resources :people
  resources :localities
  resources :states
  
  get 'inscripcion' => 'inscripcion#index'
  
  devise_for :users

  root 'welcome#index'

  get '/felicitaciones' => 'people#felicitaciones'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
