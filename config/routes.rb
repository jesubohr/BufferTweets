Rails.application.routes.draw do
  root to: 'main#index'
  get 'about', to: 'about#index'

  get 'sign-up', to: 'registrations#new', as: :sign_up
  post 'sign-up', to: 'registrations#create'

  get 'sign-in', to: 'sessions#new', as: :sign_in
  post 'sign-in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'password', to: 'passwords#edit', as: :edit_password
  patch 'password', to: 'passwords#update'

  get 'password/reset', to: 'password_resets#new', as: :password_reset
  post 'password/reset', to: 'password_resets#create'

  get 'password/reset/edit', to: 'password_resets#edit', as: :password_reset_edit
  patch 'password/reset/edit', to: 'password_resets#update'

  get 'auth/:provider/callback', to: 'omniauth_callbacks#twitter'
end
