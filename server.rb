require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require './lib/petshop.rb'

# #
# This is our only html view...
#

configure do
  set :bind, '0.0.0.0'
  enable :sessions
end

get '/' do
  if session[:user_id]
    # TODO: Grab user from database
    Petshops::UserRepo.find_by_id(mydb, session[:user_id])
  end
  erb :index
end

def mydb
  Petshops.create_db_connection('petserver')
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do

  headers['Content-Type'] = 'application/json'
  # RestClient.get("http://pet-shop.api.mks.io/shops")
  JSON.generate(Petshops::ShopRepo.all(mydb))
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']
  creds = Petshops::UserRepo.find_by_name(mydb, username)

  # TODO: Grab user by username from database and check password
  # user = { 'username' => 'alice', 'password' => '123' }

  if creds['password'] == password
    headers['Content-Type'] = 'application/json'
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    session[:user_id] = creds['id']

    

    cats = Petshops::CatRepo.find_by_owner_id(mydb, session[:user_id])
    creds['cats'] = []
    cats.each do |cat|
      creds['cats'] << {shopid: cat['shopId'], name: cat['name'], imageUrl: cat['imageUrl'], adopted: true, id: cat['id']}
    end
    
    dogs = Petshops::DogRepo.find_by_owner_id(mydb, session[:user_id])
    creds['dogs'] = []
    dogs.each do |dog|
      creds['dogs'] << {shopid: dog['shopId'], name: dog['name'], imageUrl: dog['imageUrl'], adopted: true, id: dog['id']}
    end

    JSON.generate(creds)
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
  data = Petshops::CatRepo.find_by_shop_id(mydb, id)
  data.each do |line|
    line['adopted'] = (line['adopted'] == 't' ? true : false)
  end
  JSON.generate(data)
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  owner_id = session[:user_id]
  # TODO: Grab from database instead
  # RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/cats/#{id}",
  #   { adopted: true }, :content_type => 'application/json')
  # TODO (after you create users table): Attach new cat to logged in user
  JSON.generate(Petshops::CatRepo.save(mydb, {
      'id' => id,
      'shop_id' => shop_id,
      'owner_id' => owner_id
    }))
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Update database instead
  # RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/dogs")
  data = Petshops::DogRepo.find_by_shop_id(mydb, id)
  
  data.each do |line|
    line['adopted'] = (line['adopted'] == 't' ? true : false)
  end

  JSON.generate(data)
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  owner_id = session[:user_id]
  # TODO: Update database instead
  # RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs/#{id}",
  #   { adopted: true }, :content_type => 'application/json')
  # TODO (after you create users table): Attach new dog to logged in user
  JSON.generate(Petshops::DogRepo.save(mydb, {
      'id' => id,
      'shop_id' => shop_id,
      'owner_id' => owner_id
    }))
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
