Rails.application.routes.draw do

get 'teams' => 'teams#index'
get 'teams/:team_id' => 'teams#show'

post 'events/create' => 'events#create'
end
