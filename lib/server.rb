require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'

require './lib/petshop.rb'

set :bind, '0.0.0.0'

# #
# This is our only html view...
#
get '/' do
  if session[:user_id]
    # TODO: Grab user from database
    @current_user = $sample_user
  end
  erb :index
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do
  headers['Content-Type'] = 'application/json'
  # RestClient.get("http://pet-shop.api.mks.io/shops")
  db = PetShopServer.create_db_connection('pet_shop_server')
  JSON.generate(PetShopServer::ShopsRepo.all_shops(db))
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  # TODO: Grab user by username from database and check password
  db = PetShopServer.create_db_connection('pet_shop_server')
  JSON.generate(PetShopServer::UsersRepo.authenticate(db, username))

  if password == user['password']
    headers['Content-Type'] = 'application/json'
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    session[:user_id] = user['id']
    $sample_user.to_json
    db = PetShopServer.create_db_connection('pet_shop_server')
    JSON.generate(PetShopServer::UsersRepo.all_pets(db, user['id']))
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
  # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/cats")
  db = PetShopServer.create_db_connection('pet_shop_server')
  JSON.generate(PetShopServer::CatsRepo.all_cats(db, params[:id]))
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Grab from database instead
  # RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/cats/#{id}",
    # { adopted: true }, :content_type => 'application/json')
  db = PetShopServer.create_db_connection('pet_shop_server')
  JSON.generate(PetShopServer::CatsRepo.adopt(db, { 'id' => id, 'shopId' => shop_id }))
  # TODO (after you create users table): Attach new cat to logged in user
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Update database instead
  # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/dogs")
  db = PetShopServer.create_db_connection('pet_shop_server')
  JSON.generate(PetShopServer::DogsRepo.all_dogs(db, params[:id]))
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Update database instead
  # RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs/#{id}",
  #   { adopted: true }, :content_type => 'application/json')
  db = PetShopServer.create_db_connection('pet_shop_server')
  JSON.generate(PetShopServer::DogsRepo.adopt(db, { 'id' => id, 'shopId' => shop_id }))
  # TODO (after you create users table): Attach new dog to logged in user
end


$sample_user = {
  id: 999,
  username: 'alice',
  cats: [
    { shopId: 1, name: "NaN Cat", imageUrl: "http://i.imgur.com/TOEskNX.jpg", adopted: true, id: 44 },
    { shopId: 8, name: "Meowzer", imageUrl: "http://www.randomkittengenerator.com/images/cats/rotator.php", id: 8, adopted: "true" }
  ],
  dogs: [
    { shopId: 1, name: "Leaf Pup", imageUrl: "http://i.imgur.com/kuSHji2.jpg", happiness: 2, id: 2, adopted: "true" }
  ]
}
