require 'sinatra'
require 'sinatra/json'
require "sinatra/reloader" if development?

require_relative 'songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant


get '/' do
  "Hello World Whats UP"
end

