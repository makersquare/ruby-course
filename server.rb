require 'sinatra'
require './lib/library_plus'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/users' do
  db = Library.create_db_connection('library-dev')
  @users = Library::UserRepo.all(db)
  erb :"users/index"
end 

post '/users' do
  puts params
  @name = params
  db = Library.create_db_connection('library-dev')
  Library::UserRepo.save(db, @name) 
  @users = Library::UserRepo.all(db)
  erb :"users/index"
end 