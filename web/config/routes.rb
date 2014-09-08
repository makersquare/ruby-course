Rails.application.routes.draw do
  resources :orders, :only => [:index, :create]
  resources :items, :except => [:new]
  root 'home#index'
end
