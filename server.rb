require 'sinatra'
require './lib/library_plus'

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
 Library::UserRepo.save(db,params)
 redirect to('/users')
end

get '/books' do
 db = Library.create_db_connection('library_dev')
 @books = Library::BookRepo.all(db)
 erb :"books/index"
end

post '/books' do
  db = Library.create_db_connection('library_dev')
  book = Library::BookRepo.save(db, params)
  redirect to("/books")
end

get '/books/:id' do
  db = Library.create_db_connection('library_dev')
  @book = Library::BookRepo.find(db,params[:id])
  @bookstat = Library::BookRepo.get_status(db, params[:id])
  @borrower = nil
  if @bookstat["status"] == "checked out"
    @borrower = Library::BookRepo.getborrower(db, params[:id])
  end
  @users = Library::UserRepo.all(db)
  erb :"books/show"
end

post '/books/:id/checkout' do
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.checkout(db,params["userid"], params["id"])
  redirect to("/books/"+params[:id])
end

post '/books/:id/return' do
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.return(db, params[:id])
  redirect to("/books/"+params[:id])
end