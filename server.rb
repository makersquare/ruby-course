require 'sinatra'
require 'sinatra/reloader'
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
  if params['user_name']
    user = {'name' => params["user_name"]}
    Library::UserRepo.save(db, user)
  elsif params['user_id']
    id = params["user_id"]
    Library::UserRepo.destroy(db, id)
  end
  redirect to('/users')
end

get '/users/:id' do
  id = params['id']
  db = Library.create_db_connection('library_dev')
  @user = Library::UserRepo.find(db, id)
  erb :"users/show"
end

get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/books' do 
  db = Library.create_db_connection('library_dev')
  puts params
  if params['book_title'] && params['book_author']
    user = {'title' => params['book_title'], 'author' => params['book_author']}
    Library::BookRepo.save(db, user)
  elsif params['book_id']
    id = params["book_id"]
    Library::BookRepo.destroy(db, id)
  end
  redirect to('/books')
end

get '/books/:id' do
  id = params['id']
  db = Library.create_db_connection('library_dev')
  @book = Library::BookRepo.find(db, id)
  @users = Library::UserRepo.all(db)
  erb :"books/show"
end

post '/books/:id/checkout' do 
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.check_out_book(db, params['user_id'], params['id'])
  Library::BookRepo.status(db, params['id'])
  redirect to('/books/' + params['id'])
end

post '/books/:id/checkin' do 
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.check_in_book(db, params['id'])
  Library::BookRepo.status(db, params['id'])
  redirect to('/books/' + params['id'])
end
