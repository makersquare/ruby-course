require 'sinatra'
require './lib/library_plus'
require 'pry-byebug'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/users' do
  Library.create_db('library_dev')
  db = Library.create_db_connection('library_dev')
  Library.create_tables(db)
  @users = Library::UserRepo.all(db)
  erb :"users/index"
end

post '/users' do
  # puts params
  username = params[:user_name]
  db = Library.create_db_connection('library_dev')
  Library::UserRepo.save(db, { 'name' => username })
  @users = Library::UserRepo.all(db)
  erb :"users/index"
end
