require 'sinatra'
require_relative 'lib/puppy.rb'
require_relative 'lib/request.rb'
require_relative 'lib/puppymill.rb'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

post '/' do
  puts params
  @word = params[" "]

end


