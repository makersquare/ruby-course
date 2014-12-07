require 'sinatra'
require './lib/library_plus'

# set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :"index"
end

get "/users" do
  db = Library.create_db_connection('library_dev')
  @users = Library::UserRepo.all(db)
  
  erb :"users/index"
end
