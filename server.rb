require 'sinatra'
# require 'sinatra/reloader'
require 'rest-client'
require 'json'
require_relative 'lib/pet-shop.rb'

set :bind, '0.0.0.0'
configure do
    enable :sessions
  end
# #
# This is our only html view...
#
get '/' do
  if session['user_id']
    # TODO: Grab user from database
    db = PetShop.create_db_connection()
    @user = PetShop::UsersRepo.find(db, session[:user_id])
    @current_user = @user['name']

  end
  erb :index
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do
  headers['Content-Type'] = 'application/json'
  db = PetShop.create_db_connection()
  JSON.generate(PetShop::Shops.get_all_shops(db))
end

get '/signup' do

  erb :"signup"
end
post '/signup' do
  db = PetShop.create_db_connection()
  password_hash = BCrypt::Password.create(params['password'])
  PetShop::UsersRepo.save db, {username: params['username'], password: password_hash}
  erb :"signup"
end
post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']
  db = PetShop.create_db_connection() 
  user = PetShop::UsersRepo.find_by_name(db, username)
  # TODO: Grab user by username from database and check password
  pass_from_db = BCrypt::Password.new(user['password'])

  if pass_from_db == password
    headers['Content-Type'] = 'application/json'
    session['user_id'] = user['id']
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    user = PetShop::UsersRepo.get_adoptions(db, user)
    user.delete('password')
    JSON.generate(user)
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
  # TODO: Grab from database   instead
  db = PetShop.create_db_connection()
  cats = PetShop::CatsRepo.all_from_shop(db, id)
  JSON.generate(cats)
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
    adopt_data = {
    type: 'cat',
    user_id: session['user_id'],
    pet_id: id
    }
  # TODO: Grab from database instead
  db = PetShop.create_db_connection()
  PetShop::UsersRepo.adopt(db, adopt_data)
  # TODO (after you create users table): Attach new cat to logged in user
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  db = PetShop.create_db_connection()
  id = params[:id]

  dogs = PetShop::DogsRepo.all_from_shop(db, id)
  JSON.generate(dogs)
  # TODO: Update database instead
  # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/dogs")
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  db = PetShop.create_db_connection()
  @user = PetShop::UsersRepo.find(db, session["user_id"])
  # TODO: Update database instead
  adopt_data = {
    type: 'dog',
    user_id: session[:user_id].to_i,
    pet_id: id
    }  
  PetShop::UsersRepo.adopt(db, adopt_data)
  # RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs/#{id}",
  #   { adopted: true }, :content_type => 'application/json')
  # TODO (after you create users table): Attach new dog to logged in user
  JSON.generate(adopt_data)
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
