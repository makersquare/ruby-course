require 'sinatra'
require 'sinatra/reloader'
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
  if params['user_name']
    user = {'name' => params["user_name"]}
    Library::UserRepo.save(db, user)
  elsif params['user_id']
    id = params["user_id"]
    Library::UserRepo.destroy(db, id)
  end
  redirect to('/users')
end

get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/books' do 
  
end

get '/books' do
  #Create a new books
  erb :"book/show"
end

get '/books/:id' do
  erb :"books/show"
end
