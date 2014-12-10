require 'sinatra'
require 'sinatra/json'
require_relative 'songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant


get '/' do
  @message = "Hello World"
  @remarks = ["I am", "A Group Of", "Messages", "Make Sure", "You Check", "The ERB tags"]
  erb :index
end

