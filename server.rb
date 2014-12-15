require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'

set :bind, '0.0.0.0'
enable :sessions

require_relative 'lib/petshop.rb'

# #
# This is our only html view...
#
get '/' do
  if session[:user_id]
   user_id = session['user_id']
    # TODO: Grab user from database
   # db = Petshop.create_db_connection('Petshop_Test')
   # @current_user = Petshop::UsersRepo.find(db, user_id)
   @current_user = $awesome_user
  end
  erb :index
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do
  headers['Content-Type'] = 'application/json'
  # RestClient.get("http://pet-shop.api.mks.io/shops")
  db = Petshop.create_db_connection('Petshop_Test')
  Petshop::ShopsRepo.all(db).to_json
end

post '/signin' do

  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  # # TODO: Grab user by username from database and check password
  db = Petshop.create_db_connection('Petshop_Test')
  user = Petshop::UsersRepo.find_by_name(db, params['username'])

  $awesome_user = { username: params['username']}

  if user
    if password == user['password']
    headers['Content-Type'] = 'application/json'
  #   # TODO: Return all pets adopted by this user
    session[:user_id] = user['id']
    $awesome_user.to_json

    else
      status 401
    end
  else
      status 401
  end

  # user = { 'username' => 'alice', 'password' => '123' }

  # if password == user['password']
  #   headers['Content-Type'] = 'application/json'
  
  #   # TODO: Set session[:user_id] so the server will remember this user has logged in
  #   $sample_user.to_json
  # else
  #   status 401
  # end
end

 # # # #
# Cats #
# # # #
get '/shops/:id/cats' do
  headers['Content-Type'] = 'application/json'
  #id = params[:id]
  shop_id = params[:id]
  # TODO: Grab from database instead
  #RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/cats")
  db = Petshop.create_db_connection('Petshop_Test')
  cats = Petshop::CatsRepo.find_by_shopid(db, shop_id)
  cats.to_json
end

## CAT ADOPTION: WORK IN PROGRESS
put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  params = JSON.parse request.body.read
  
  shop_id = params[:shop_id]
  id = params[:id]

  db = Petshop.create_db_connection('Petshop_Test')
  avail_cats = Petshop::CatsRepo.find_available(db, adopted)
  avail_cats.to_json  
  
  # TODO: Grab from database instead
  # RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/cats/#{id}",
  #   { adopted: true }, :content_type => 'application/json')
  # TODO (after you create users table): Attach new cat to logged in user
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:id]
  # TODO: Update database instead
  #RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/dogs")
  db = Petshop.create_db_connection('Petshop_Test')
  dogs = Petshop::DogsRepo.find_by_shopid(db, shop_id)
  dogs.to_json
end

## DOG ADOPTION: WORK IN PROGRESS
put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Update database instead
  RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs/#{id}",
    { adopted: true }, :content_type => 'application/json')
  # TODO (after you create users table): Attach new dog to logged in user
end


# $sample_user = {
#   id: 999,
#   username: 'alice',
#   cats: [
#     { shopId: 1, name: "NaN Cat", imageUrl: "http://i.imgur.com/TOEskNX.jpg", adopted: true, id: 44 },
#     { shopId: 8, name: "Meowzer", imageUrl: "http://www.randomkittengenerator.com/images/cats/rotator.php", id: 8, adopted: "true" }
#   ],
#   dogs: [
#     { shopId: 1, name: "Leaf Pup", imageUrl: "http://i.imgur.com/kuSHji2.jpg", happiness: 2, id: 2, adopted: "true" }
#   ]
# }
