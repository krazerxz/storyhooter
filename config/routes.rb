Rails.application.routes.draw do
  get 'user/new', to: 'users#new'

  root 'home#index'
end
