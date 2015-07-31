Rails.application.routes.draw do
  get 'user/new',  to: 'users#new'
  get 'user/:id', to: 'users#show', as: 'user'
  post 'user/new', to: 'users#create'

  root 'home#index'
end
