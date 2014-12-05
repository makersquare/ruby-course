require 'sinatra'
require './lib/library_plus'
require 'sinatra/reloader'

# set :bind, '0.0.0.0' # This is needed for Vagrant

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
  @u = Library::UserRepo.save(db, :name => params["user_name"])
  erb :"users/create"
end

get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/books' do
  db = Library.create_db_connection('library_dev')
  @b = Library::BookRepo.save(db, {title: params["book_title"], author: params["book_author"]})
  erb :"books/create"
end