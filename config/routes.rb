Rails.application.routes.draw do
  get 'about', to: 'about#index'
  get 'sign-up', to: 'registrations#new', as: :sign_up
  post 'sign-up', to: 'registrations#create'
  root to: 'main#index'
end
