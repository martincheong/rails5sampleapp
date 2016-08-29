Rails.application.routes.draw do
  get '/home', controller: 'static_pages', action: 'home'
  get '/help', controller: 'static_pages', action: 'help'
  get '/about', controller: 'static_pages', action:'about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
  match '*path', to: redirect('/'), via: :all

end
