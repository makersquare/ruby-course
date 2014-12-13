require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'pg'
require 'json'

require_relative 'lib/pet-shop-server/petshop.rb'

configure do
  enable :sessions
end

before do

  if session[:user_id]
    # TODO: Grab user from database
    db = PetShopServer.create_db_connection 'petshop'
    @current_user = PetShopServer::PetsRepo.build_user(db, session[:user_id])
    # @current_user = PetshopServer::PetsRepo.find
  end
end

# before '/shops/*' do
#   status(401) unless @current_user
# end
# #
# This is our only html view...
#
get '/' do
  # db = PetShopServer.create_db_connection 'petshop'
  # @current_user = PetShopServer::UsersRepo.find(db, session[:user_id])
  
  # puts PetShopServer::PetsRepo.build_user(db, 999)
  @real_user.to_json
  erb :index
end

get '/logout' do
  session.clear
  redirect '/'
end


# #
# ...the rest are JSON endpoints
#UsersRepo
get '/shops' do
  headers['Content-Type'] = 'application/json'
  RestClient.get("http://pet-shop.api.mks.io/shops")
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  db = PetShopServer.create_db_connection 'petshop'
  user = PetShopServer::UsersRepo.find_by_name(db, username)

  # TODO: Grab user by username from database and check password

  # user = { 'username' => 'alice', 'password' => '123' }

  if password == user['password']
    headers['Content-Type'] = 'application/json'
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    # @real_user = PetShopServer::PetsRepo.build_user(db, user['id'])

    session["user_id"] = user['id']
    user.to_json
  else
    status 401
  end
end

 # # # #
# Cats #
# # # #
get '/shops/:id/cats' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Grab from database instead
  RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/cats")
end

put '/shops/:shop_id/cats/:id/adopt' do
  if @current_user
    headers['Content-Type'] = 'application/json'
    shop_id = params[:shop_id]
    id = params[:id]
    # TODO: Grab from database instead
    RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/cats/#{id}",
      { adopted: true }, :content_type => 'application/json')
    # TODO (after you create users table): Attach new cat to logged in user
  else
    status 401
  end
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Update database instead
  RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/dogs")
end

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
