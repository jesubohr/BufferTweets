Rails.application.routes.draw do
  get 'about', to: 'about#index'

  get 'password', to: 'passwords#edit', as: :edit_password
  patch 'password', to: 'passwords#update'

  get 'sign-up', to: 'registrations#new', as: :sign_up
  post 'sign-up', to: 'registrations#create'

  get 'sign-in', to: 'sessions#new', as: :sign_in
  post 'sign-in', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'
  root to: 'main#index'
end
