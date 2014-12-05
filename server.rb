require 'sinatra'
require './lib/library_plus'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/users' do
  db = Library.create_db_connection('library_dev')
  Library.create_tables(db)
  @users = Library::UserRepo.all(db)
  puts params
  erb :"users/index"
end

post '/users' do
  puts params
  db = Library.create_db_connection('library_dev')
  Library::UserRepo.save(db, params)
  @users = Library::UserRepo.all(db)
  redirect to ('/users')
end