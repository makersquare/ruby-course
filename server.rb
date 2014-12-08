require 'sinatra'
require './lib/library_plus'
require 'sinatra/reloader'
require 'json'

# set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/users' do
  db = Library.create_db_connection('library_dev')
  @users = Library::UserRepo.all_with_checkouts(db)
  erb :"users/index"
end
get '/users/:id' do
  db = Library.create_db_connection('library_dev')
  @user = Library::UserRepo.find_with_checkouts(db, params[:id])
  erb :"users/info"
end
post '/users' do
  db = Library.create_db_connection('library_dev')
  @u = Library::UserRepo.save(db, "name" => params["user_name"])
  redirect to("/users")
end

get '/users/:id/delete' do
  db = Library.create_db_connection('library_dev')
  r = Library::UserRepo.destroy(db, params["id"])
  if(r.split().last == "1")
    @u = "User ##{params["id"]} has been deleted successfully!"
  else
    @u = "Error deleting user ##{params["id"]}."
  end
  erb :"users/delete"
end

get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  @users = JSON.generate(Library::UserRepo.all(db)) # Querying this to populate checkout list.
  erb :"books/index"
end

post '/books' do
  db = Library.create_db_connection('library_dev')
  @b = Library::BookRepo.save(db, {"title" => params["book_title"], "author" => params["book_author"]})
  redirect to("/books")
end

get '/books/:id' do
  db = Library.create_db_connection('library_dev')
  @book = Library::BookRepo.find(db, params['id'])
  erb :"books/info"
end

get '/books/:id/delete' do
  db = Library.create_db_connection('library_dev')
  r = Library::BookRepo.destroy(db, params["id"])
  if(r.split().last == "1")
    @u = "Book ##{params["id"]} has been deleted successfully!"
  else
    @u = "Error deleting book ##{params["id"]}."
  end
  erb :"books/delete"
end

get '/books/:id/checkout' do
  db = Library.create_db_connection('library_dev')
  @users = Library::UserRepo.all(db)
  @book = Library::BookRepo.find(db, params['id'])
  erb :"books/checkout"
end

post '/books/:id/checkout' do
  db = Library.create_db_connection('library_dev')
  Library.CheckoutRepo.save(db, checkout_data)
  redirect to("/books")
end