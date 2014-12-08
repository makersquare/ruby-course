require 'sinatra'
require './lib/library_plus'
require 'bundler/setup'
require 'sinatra/reloader'
require './lib/library_plus/user_repo'
require './lib/library_plus/book_repo'

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
  @new_user = {'name' => params[:user_name]}
  db = Library.create_db_connection('library_dev')
  Library::UserRepo.save(db, @new_user)
  redirect to ('/users')
end

get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/books' do
  db = Library.create_db_connection('library_dev')
  @title = params[:title]
  @author = params[:author]
  Library::BookRepo.save(db, @title, @author)
  redirect to ('/books')
end

get '/books/:id' do
  # @id = params[:id]
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.all(db)
  @books.each do |book|
    if book['id'] == params[:id]
      @showbook = book
    end
  end
  z = false
  @checkedbook = Library::BookRepo.all_check_out(db)
  @checkedbook.each do |book|
    if @showbook['id'] == book['book_id']
      @status = 'checked out'
      z = true
    end
  end
  if z == false
    @status = 'available'
  end
  @users = Library::UserRepo.all(db)
  erb :"books/show"
end

post '/books/:id/checkout' do
  y = params[:id]
  @x = params[:userid]
  # z = false
  # @error = ""
  db = Library.create_db_connection('library_dev')
  # @checkedbooks = Library::BookRepo.all_check_out(db)
  # @checkedbooks.each do |book|
  #   if params[:id] == book['id']
  #     @error = "That book is already checked out."
  #   else
  #     z = true
  #   end
  # end
  # if z == false
    Library::BookRepo.check_out(db, y, @x)
  # end
  redirect to ('/books')
end

