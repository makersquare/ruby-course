require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'pry-byebug'
# require 'rack-flash'

require_relative 'lib/petshop.rb'

class PetShop::Server < Sinatra::Application

  set :bind, '0.0.0.0' # This is needed for Vagrant

  configure do
    enable :sessions
    # use Rack::Flash
  end

  before do
    if session[:user_id]
      owner_id = session['user_id']
      @db = PetShop.create_db_connection 'petshop_dev'
      @current_user = PetShop::OwnerRepo.find @db, owner_id
    else
      @current_user = $sample_user
    end
  end

  # #
  # This is our only html view...
  #
  get '/' do
    erb :index
  end

  # #
  # ...the rest are JSON endpoints
  #
  get '/shops' do
    headers['Content-Type'] = 'application/json'
    shops = PetShop::ShopRepo.all(@db)
  end

  post '/signin' do
    params = JSON.parse request.body.read

    username = params['username']
    password = params['password']

    # TODO: Grab user by username from database and check password
    owner = Petshop::OwnerRepo.find_by_name(@db, username)
    # user = { 'username' => 'alice', 'password' => '123' }

    # Validate credentials Valid
    if password == owner['password']
      headers['Content-Type'] = 'application/json'

      # TODO: Return all pets adopted by this user
      @current_user['cats'] = Petshop::CatRepo.find_all_by_owner(@db, owner_id)
      @current_user['dogs'] = Petshop::DogRepo.find_all_by_owner(@db, owner_id)

      # TODO: Set session[:user_id] so the server will remember this user has logged in
      session['user_id'] = owner['id']

      @current_user.to_json
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
    
    Petshop::CatRepo.find_all_by_shop(@db, id)
  end

  put '/shops/:shop_id/cats/:id/adopt' do
    headers['Content-Type'] = 'application/json'
    # shop_id = params[:shop_id]
    id = params[:id]
    # Grab Cat data from database

    owner = Petshop::OwnerRepo.find(@db, @current_user['id'])
    cat = Petshop::CatRepo.save(@db, {'id' => id, 'owner_id' => owner['id'], 'adopted_status' => true})
  end


   # # # #
  # Dogs #
  # # # #
  get '/shops/:id/dogs' do
    headers['Content-Type'] = 'application/json'
    id = params[:id]
    dogs = Petshop::DogRepo.find_all_by_shop(@db, id)
  end

  put '/shops/:shop_id/dogs/:id/adopt' do
    headers['Content-Type'] = 'application/json'
    shop_id = params[:shop_id]
    id = params[:id]
    
    owner = Petshop::OwnerRepo.find(@db, @current_user['id'])
    cat = Petshop::DogRepo.save(@db, {'id' => id, 'owner_id' => owner['id'], 'adopted_status' => true})

  end


  $sample_user = {
    id: 999,
    username: 'anonymous',
    cats: [
      { shopId: 1, name: "NaN Cat", imageUrl: "http://i.imgur.com/TOEskNX.jpg", adopted_status: true, id: 44 },
      { shopId: 8, name: "Meowzer", imageUrl: "http://www.randomkittengenerator.com/images/cats/rotator.php", id: 8, adopted_status: true }
    ],
    dogs: [
      { shopId: 1, name: "Leaf Pup", imageUrl: "http://i.imgur.com/kuSHji2.jpg", happiness: 2, id: 2, adopted_status: true }
    ]
  }
end