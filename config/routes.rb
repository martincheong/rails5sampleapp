Rails.application.routes.draw do
  get 'users/new',  as: 'signup'

  get '/home',      to: 'static_pages#home'
  get '/help',      to: 'static_pages#help'
  get '/about',     to: 'static_pages#about'
  get '/contact',   to:'static_pages#contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  match '*path', to: redirect('/'), via: :all

end
