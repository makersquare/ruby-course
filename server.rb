require 'sinatra'
require './lib/library_plus'

# set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/books' do
  erb :"books/index"
end

get '/books' do
  #Create a new books
  erb :"book/show"
end

get '/books/:id' do
  erb :"books/show"
end
