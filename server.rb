require 'sinatra'
require './lib/library_plus'

set :bind, '0.0.0.0' # This is needed for Vagrant



get '/' do
  erb :index
end

get '/users' do
  db = Library.create_db_connection('library_dev')
  @users = Library::UserRepo.all(db)
  erb :'users/index'
end

post '/users/create' do
  db = Library.create_db_connection('library_dev')
  Library::UserRepo.save(db, params)
  redirect '/users'
end

get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  erb :'books/index'
end

post '/books/create' do
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.save(db, params)
  redirect '/books'
end 

get '/books/:id' do
  db = Library.create_db_connection('library_dev')
  book_data = Library::BookRepo.find(db, params[:id])
  @title = book_data['title']
  @author = book_data['author']
  @status = book_data['status']
  @id = book_data['id']
  @users = Library::UserRepo.all(db)
  puts book_data['borrower_id']
  if book_data['borrower_id'] != nil
    user = Library::UserRepo.find(db, book_data['borrower_id'])
    puts user
    @name = user['name']
    @borrower_id = user['id']
  end
  erb  :'books/shell'
end

post '/books/:id/check-out' do
  db = Library.create_db_connection('library_dev')
  puts params
  Library::BookRepo.check_out(db,params[:id],params[:user])
  redirect "/books"
end
  
post '/books/check-in' do
  db = Library.create_db_connection('library_dev')
  puts params
  Library::BookRepo.check_in(db,params[:id].to_i)
  redirect "/books"
end  