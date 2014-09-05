require 'sinatra'
require_relative 'lib/puppy_breeder.rb'
require 'pry-byebug'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/puppy' do
  erb :puppy
end

post '/puppy' do
  puppy = PuppyBreeder::Puppy.new(params["breed"], params["name"], params["age"])
  # if PuppyBreeder::Repos::PuppyContainer.log[puppy.breed].nil?
  #   PuppyBreeder::Repos::PuppyContainer.add_breed(puppy.breed)
  # end
  PuppyBreeder::Repos::PuppyContainer.add_puppy(puppy)
  redirect to '/puppies'
end

get '/puppies' do
  puppies = PuppyBreeder::Repos::PuppyContainer.log
  @puppy_list = puppies.map { |key, val| val[:available_puppies] }.flatten
  erb :puppies
end

get '/request' do
  puppies = PuppyBreeder::Repos::PuppyContainer.log
  @puppy_list = puppies.map { |key, val| val[:available_puppies] }.flatten
  erb :request
end

post '/request' do
  request = PuppyBreeder::PurchaseRequest.new(params["breed"])
  PuppyBreeder::Repos::PurchaseRequestContainer.add_request(request)
  redirect to '/requests'
end

get '/requests' do
  @request_list = PuppyBreeder::Repos::PurchaseRequestContainer.log
  @puppy_list = PuppyBreeder::Repos::PuppyContainer.log
  # binding.pry
  erb :requests
end
