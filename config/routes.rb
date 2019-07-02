Rails.application.routes.draw do
  resources :cohorts, only: [:show, :edit, :update]
  resources :users, only: [:new, :create]
  resources :blogs, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :students, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/student/:id/home', to: 'students#home', as: 'home_student'

  get '/tcf/:id/home', to: 'tcfs#home', as: 'home_tcf'

  root 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
end
