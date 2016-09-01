Rails.application.routes.draw do
  root 'static_pages#home'

  get     '/signup',    to: 'users#new'
  post    '/signup',    to: 'users#create'
  get     '/home',      to: 'static_pages#home'
  get     '/help',      to: 'static_pages#help'
  get     '/about',     to: 'static_pages#about'
  get     '/contact',   to: 'static_pages#contact'
  get     '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'
  

  resources :users, except: [:new]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create,:edit,:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '*path', to: redirect('/'), via: :all

end
