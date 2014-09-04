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
  if PuppyBreeder::puppy_container.puppies[puppy.breed].nil?
    PuppyBreeder::puppy_container.add_breed(puppy.breed)
  end
  PuppyBreeder::puppy_container.add_puppy(puppy)
  redirect to '/puppies'
end

get '/puppies' do
  puppies = PuppyBreeder::puppy_container.puppies
  @puppy_list = puppies.map { |key, val| val[:available_puppies] }.flatten
  erb :puppies
end

get '/purchase_request' do
  puppies = PuppyBreeder::puppy_container.puppies
  @puppy_list = puppies.map { |key, val| val[:available_puppies] }.flatten
  erb :purchase_request
end

post '/purchase_request' do
  request = PuppyBreeder::PurchaseRequest.new(params["breed"])
  PuppyBreeder::purchase_request_container.add_request(request)
  redirect to '/requests'
end

get '/requests' do
  @request_list = PuppyBreeder::purchase_request_container.requests
  @puppy_list = PuppyBreeder::puppy_container.puppies
  # binding.pry
  erb :requests
end
