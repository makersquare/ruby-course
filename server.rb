require 'sinatra'
require './lib/library_plus'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end


get '/users' do 
  db = Library.create_db_connection('library_dev')
  @users = Library::UserRepo.all(db)
  erb :"users/index"
end

post '/users' do 
  db = Library.create_db_connection('library_dev')
  @user_name = params['user_name']
  @user = Library::UserRepo.save(db, {'name' => @user_name })
  id = @user['id']
  redirect to("/users/#{id}")
end 

get '/users/:id' do 
  db = Library.create_db_connection('library_dev')
  @id = params['id']
  @user = Library::UserRepo.find(db, @id)
  erb :"users/user"
end   
