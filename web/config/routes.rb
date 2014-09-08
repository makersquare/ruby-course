Rails.application.routes.draw do
  resources :items, :except => [:new]
  root 'home#index'
end
