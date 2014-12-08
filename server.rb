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

get '/books' do
  db = Library.create_db_connection('library-dev')
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/new_book' do
  puts params
  @title = params
  db =Library.create_db_connection('library-dev')
  Library::BookRepo.save(db, @title)
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/checkin' do
  puts params
  @checked_in = params
  db = Library.create_db_connection('library-dev')
  Library::BookRepo.check_in(db, @checked_in)
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/checkout' do
  puts params
  @checked = params
  db = Library.create_db_connection('library-dev')
  Library::BookRepo.check_out(db, @checked)
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end
