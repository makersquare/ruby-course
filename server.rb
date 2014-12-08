require 'sinatra'
require './lib/library_plus'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  db = Library.create_db_connection('library_dev')
  Library.create_tables(db)
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
  # @users = Library::UserRepo.all(db)
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
  Library.create_tables(db)
  book_id = params['id'].to_i
  user_name = "whatever"
  @results = Library::BookRepo.find(db, book_id)
  @users = Library::UserRepo.all(db)
  @status = Library::BookRepo.checkout_status(db, book_id)
  puts @status
  @history = Library::BookRepo.checkout_history(db, book_id)
  # @checkout = Library::BookRepo.checkout(db, book_id, user_name)
  erb :"books/show"
end

post '/books/:id/checkout' do
  puts params
  user_name = params[:user_name]
  book_id = params[:id]
  db = Library.create_db_connection('library_dev')
  Library.create_tables(db)
  status = Library::BookRepo.checkout_status(db,book_id)
  Library::BookRepo.checkout(db, book_id, user_name)
  # book_id = params['id'].to_i
  # user_name = "whatever"
  # @results = Library::BookRepo.find(db, book_id)
  # @users = Library::UserRepo.all(db)
  # @checkout = Library::BookRepo.checkout(db, book_id, user_name)
  # db = Library.create_db_connection('library_dev')
  # Library.create_tables(db)
  # puts params
  # id = params['id'].to_i
  # @results = Library::BookRepo.find(db, id)
  # @users = Library::UserRepo.all(db)
  # @checkout = Library::BookRepo.checkout(db, id)
  status = Library::BookRepo.checkout_status(db,book_id)
  redirect to ("books/#{book_id}")
end

post '/books/:id/checkin' do
  book_id = params[:id]
  db = Library.create_db_connection('library_dev')
  Library.create_tables(db)
  Library::BookRepo.checkin(db, book_id)
  redirect to ("books/#{book_id}")
end

get '/books/:id/unavailable' do
  erb :"books/unavailable"
end

