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
  @user_name = params['user_name']
  @user = Library::UserRepo.save(db, {'name' => @user_name })
  id = @user['id']
  redirect to("/users/#{id}")
end 

get '/users/:id' do 
  db = Library.create_db_connection('library_dev')
  @id = params['id']
  @user = Library::UserRepo.find(db, @id)
  @books = Library::BookRepo.find_all_checkeout_books(db, @id)
  erb :"users/user"
end  

# require_relative 'lib/library_plus.rb'
get '/books' do 
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
 erb :"books/index" 
end 


post '/books' do 
  db = Library.create_db_connection('library_dev')
  @book_title = params['book_title']
  @book_author = params['book_author']
  @book = Library::BookRepo.save(db, {'title' => @book_title, 'author' => @book_author})
  id = @book['id']
  redirect to("/books/#{id}")
end 

get '/books/:id' do 
  db = Library.create_db_connection('library_dev')
  @id = params['id']
  @book = Library::BookRepo.find(db, @id)
  @users = Library::BookRepo.find_all_checkeout_user(db, @id)
  @status = Library::BookRepo.checked_out?(db, @id)
  erb :"/books/show"
end


get '/books/:id/checkout' do
  db = Library.create_db_connection('library_dev')
  @id = params['id']
  @users = Library::UserRepo.all(db)
  erb :"/books/checkout"
end

post '/books/:id/checkout' do 
  db = Library.create_db_connection('library_dev')
  @id = params['id']
  # Library::BookRepo.checkout(db, @id)
  redirect to("/books/#{@id}/checkout")
end 

post '/books/:id' do 
  @id = params['id']
  @user_id = params['user_id']
  db = Library.create_db_connection('library_dev')
  @status_now = Library::BookRepo.checked_out?(db, @id)
  @book = Library::BookRepo.check_out(db, @id, @user_id, @status_now)
  redirect to("/books/#{@id}")
end 
 
post '/books/:id/checkin' do 
  db = Library.create_db_connection('library_dev')
  @id = params['id']
  Library::BookRepo.checkin(db, @id)
  redirect to("/books/#{@id}")
end 

 
