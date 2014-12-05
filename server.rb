require 'sinatra'
require './lib/library_plus'
require './lib/library_plus/user_repo'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/users' do
  db = PG.connect(host: 'localhost', dbname: 'library_dev')
  @users = Library::UserRepo.all(db).entries
  erb :'/users/index'
end

get '/users/:id' do
  erb :userpage
end

post '/users' do
  db = PG.connect(host: 'localhost', dbname: 'library_dev')
  Library::UserRepo.save(db, params)
  redirect to ('/users')
end

get '/books' do
  db = PG.connect(host: 'localhost', dbname: 'library_dev')
  @books = Library::BookRepo.all(db).entries
  erb :'/books/index'
end

get '/books/:id' do
  erb :bookpage
end

post '/books' do
  db = PG.connect(host: 'localhost', dbname: 'library_dev')
  Library::BookRepo.save(db, params)
  redirect to ('/books')
end