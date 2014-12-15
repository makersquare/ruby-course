require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'rack-flash'
require 'pry-byebug'
require 'json' 
require 'pg'  

#bundle exec ruby server.rb
#bundle exec rspec

require_relative 'lib/petshopserver.rb'
  
  configure do
    set :bind, '0.0.0.0'
    enable :sessions
    use Rack::Flash
  end

  helpers do
    def mydb
      db = Petshopserver.create_db_connection 'petshopserver'
    end
  end

get '/' do
  if session['user_id']
    user_id = session['user_id']
    @current_user = Petshopserver::UsersRepo.find mydb, user_id
    cats  = Petshopserver::UsersRepo.find_all_cats_by_user_id mydb, user_id
    dogs = Petshopserver::UsersRepo.find_all_dogs_by_user_id mydb, user_id
    @current_user['cats'] = cats
    @current_user['dogs'] = dogs
    @current_user.to_json
  end
  erb :index
end


get '/logout' do
  session.delete 'user_id'
  redirect to '/'
end

get '/shops' do
  headers['Content-Type'] = 'application/json'
  shops = Petshopserver::ShopsRepo.all mydb
  shops.to_json
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  user = Petshopserver::UsersRepo.find_by_username(mydb, username)
 
  if password == user['password']
    headers['Content-Type'] = 'application/json'
    session['user_id'] = user['id']
    @current_user = Petshopserver::UsersRepo.find mydb, user['id']
    cats  = Petshopserver::UsersRepo.find_all_cats_by_user_id mydb, user['id']
    dogs = Petshopserver::UsersRepo.find_all_dogs_by_user_id mydb, user['id']
    @current_user['cats'] = cats
    @current_user['dogs'] = dogs
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
  cats = Petshopserver::CatsRepo.all_by_shop mydb, id
  cats.to_json
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  cat_id = params[:id]
  user_id = session['user_id']

  cat = Petshopserver::UsersRepo.adopt_cat mydb, user_id, cat_id
  cat.to_json
end

 # # # #
# Dogs #
# # # #

get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  dogs = Petshopserver::DogsRepo.all_by_shop mydb, id
  dogs.to_json
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  dog_id = params[:id]
  user_id = session['user_id']
  dog = Petshopserver::UsersRepo.adopt_dog mydb, user_id, dog_id
  dog.to_json
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
