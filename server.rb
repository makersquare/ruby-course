require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'pg'
require 'json'

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
  
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  # TODO: Grab user by username from database and check password
  user = { 'username' => 'alice', 'password' => '123' }

  if password == user['password']
    headers['Content-Type'] = 'application/json'
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    $sample_user.to_json
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
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Grab from database instead
  RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/cats/#{id}",
    { adopted: true }, :content_type => 'application/json')
  # TODO (after you create users table): Attach new cat to logged in user
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
