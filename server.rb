require 'sinatra'
require_relative 'lib/puppy_breeder.rb'

get '/' do
  'hello world'
end

get '/puppy' do
  erb :puppy
end

post '/puppy' do
  puppy = PuppyBreeder::Puppy.new(params["name"], params["age"], params["breed"])
  if PuppyBreeder::PuppyContainer.puppy_info[puppy.breed].nil?
    PuppyBreeder::PuppyContainer.add_breed(puppy.breed)
  end
  PuppyBreeder::PuppyContainer.add_puppy(puppy)
  redirect to '/puppies'
end

get '/puppies' do
  puppies = PuppyBreeder::PuppyContainer.puppy_info
  @puppy_list = puppies.map { |key, val| val[:list] }.flatten
  erb :puppies
end

get '/purchase_request' do
  erb :purchase_request
end

post '/purchase_request' do

end

get '/requests' do
  erb :requests
end