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

get '/books' do
  db = Library.create_db_connection('library_dev')
  Library.create_tables(db)
  @books = Library::BookRepo.all(db)
  erb :'books/index'
end

post '/books' do
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.save(db, params)
  @books = Library::BookRepo.all(db)
  redirect to ('/books')
end

get '/books/:id' do
  db = Library.create_db_connection('library_dev')
  id = params['id'].to_i
  @results = Library::BookRepo.find(db, id)
  erb :"books/show"
end
