require 'sinatra'
require './lib/library_plus'

# set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :"index"
end

get "/users" do
  db = Library.create_db_connection('library_dev')
  @users = Library::UserRepo.all(db)

  erb :"users/index"
end

post "/users" do
  db = Library.create_db_connection('library_dev')
  @name = params[:user_name]

  Library::UserRepo.save(db, :name => @name)

  redirect back
end

get "/books" do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)

  erb :"books/index"
end

post "/books" do
  db = Library.create_db_connection('library_dev')
  @title = params[:title]
  @author = params[:author]

  Library::BookRepo.save(db, :title => @title, :author => @author)

  redirect back
end

get "/checkouts" do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  @users = Library::UserRepo.all(db)

  erb :"checkouts/index"
end

post "/checkouts" do
  db = Library.create_db_connection('library_dev')
  @book_id = params[:book_id]
  @user_id = params[:user_id]

  Library::BookRepo.check_out(db, :book_id => @book_id, :user_id => @user_id)

  redirect back
end

get "/checkouts/books-out" do
  db = Library.create_db_connection("library_dev")
  @checkouts = Library::BookRepo.get_check_outs(db)

  erb :"checkouts/books-out"
end