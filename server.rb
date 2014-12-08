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
  Library::UserRepo.save(db, {'name' => params[:user_name]})
  @users = Library::UserRepo.all(db)
  erb :"users/index"
end

get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/books' do
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.create(db, {'title' => params[:title], 'author' => params[:author]})
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

get '/books/:id' do
  db = Library.create_db_connection('library_dev')
  @book = Library::BookRepo.find(db, params[:id])
  @users = Library::UserRepo.all(db)
  erb :"books/book"
end

post '/books/:id/checkout' do
  db = Library.create_db_connection('library_dev')
  @book = Library::BookRepo.checkout(db, params[:book_id], params[:user_id])
  puts @book
  @users = Library::UserRepo.all(db)
  erb :"books/book"
end