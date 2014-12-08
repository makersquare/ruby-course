require 'sinatra'
require './lib/library_plus'
require 'pry-byebug'

set :bind, '0.0.0.0' # This is needed for Vagrant

Library.create_db('library_dev')
db = Library.create_db_connection('library_dev')
Library.create_tables(db)

get '/' do
  erb :index
end

# User Index
get '/users' do
  db = Library.create_db_connection('library_dev')
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

get '/users/*' do
  user_id = params[:splat][0]
  db = Library.create_db_connection('library_dev')
  @checked_out_books = Library::BookRepo.get_checkedOutBooks(db, { 'user_id' => user_id })
  erb :"users/summary"
end

# Book Index
get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/books' do
  # puts params
  title = params[:title]
  author = params[:author]
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.save(db, { 'title' => title, 'author' => author })
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

get '/books/:book_id' do
  # We need to choose a User that will checkout the book
  book_id = params[:book_id]
  db = Library.create_db_connection('library_dev')
  @book_history = Library::BookRepo.get_history(db, book_id)
  erb :"books/summary"
end

get '/books/:book_id/checkout' do
  # We need to choose a User that will checkout the book
  @book_id = params[:book_id]
  db = Library.create_db_connection('library_dev')
  @users = Library::UserRepo.all(db)
  erb :"books/checkout/index"
end

post '/books/:book_id/checkout/:user_id' do
  # We need to choose a User that will checkout the book
  book_id = params[:book_id]
  user_id = params[:user_id]
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.checkout(db, book_id, user_id)
  checkout_log = Library::BookRepo.get_checkedOutBooks(db, { 'user_id' => user_id })
  books = Library::BookRepo.all(db)
  @checked_out_books = []
  checkout_log.each do |log|
    book = Library::BookRepo.find(db, log['book_id'])
    @checked_out_books.push(book) 
  end
  binding.pry
  erb :"users/summary"
end

post '/books/*/return' do
  book_id = params[:splat][0]
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.checkin(db, book_id)
  erb :"books/index"
end
