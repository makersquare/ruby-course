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
  Library::UserRepo.save(db,{ 'name' => params[:title] })
  @users = Library::UserRepo.all(db)
  erb :"users/index"
end

get '/books' do
  db = Library.create_db_connection('library_dev')
  @books = Library::BookRepo.index(db)
  erb :"books/index"
end

post '/books' do
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.create(db,{ 'title' => params[:title], 'author' => params[:author] })
  @books = Library::BookRepo.index(db)
  erb :"books/index"
end

get '/books/:show' do
  db = Library.create_db_connection('library_dev')
  @users = Library::UserRepo.all(db)
  @book = Library::BookRepo.show(db, params[:show])
  @status= Library::BookRepo.show_checkouts(db, params[:show])
  if (@status == nil)
    @status = {'status' => 'available'}
  end

  erb :"books/show"
end

post '/books/:id/checkout' do
  db = Library.create_db_connection('library_dev')
  Library::BookRepo.checkout(db,params[:id], params[:user_id])
  @books = Library::BookRepo.index(db)
  erb :"books/index"
end