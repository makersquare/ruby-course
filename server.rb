require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'pry-byebug'
require_relative 'lib/PetDatabaseRepo.rb'
require_relative 'lib/repos/DB.rb'

set :bind, '0.0.0.0'
# #
# This is our only html view...
#
configure do
  set :bind, '0.0.0.0'
  enable :sessions
end

before do
  if session['user_id']
    user_id = session['user_id']
    db = PetShop::Database.dbconnect
    @current_user = PetShop::DB.find db, user_id
  else
    @current_user = {'username' => 'anonymous', 'id' => 1}
  end
end

get '/' do
  if session[:user_id]
    # TODO: Grab user from database
    # @current_user = $sample_user
  end
  erb :index
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do
  headers['Content-Type'] = 'application/json'
  # RestClient.get("http://pet-shop.api.mks.io/shops")
  db = PetShop::Database.dbconnect
  shops = PetShop::DB.get_shops(db)
  shops.to_json
 
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  # TODO: Grab user by username from database and check password
  # user = { 'username' => 'alice', 'password' => '123' }
  db = PetShop::Database.dbconnect
  user = PetShop::DB.find_by_name(db, username)
  if password == user['password']
    
    headers['Content-Type'] = 'application/json'
    
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    # $sample_user.to_json
    session[:user_id] = user['id']
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
  # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/cats")
  db = PetShop::Database.dbconnect
  cats = PetShop::DB.get_cats(db, id)
  cats.to_json
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Grab from database instead
  # RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/cats/#{id}",
    # { adopted: true }, :content_type => 'application/json')
   db = PetShop::Database.dbconnect
   PetShop::DB.adopt_cat(db, id)
  # TODO (after you create users table): Attach new cat to logged in user
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  db = PetShop::Database.dbconnect
  dogs = PetShop::DB.get_dogs(db, id)
  dogs.to_json
  # TODO: Update database instead
  # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/dogs")
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Update database instead
  # RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs/#{id}",
  #   { adopted: true }, :content_type => 'application/json')
   db = PetShop::Database.dbconnect
   PetShop::DB.adopt_dog(db, id)
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
