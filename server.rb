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
  PuppyBreeder.puppy_repo_instance.add_puppy(puppy)
  redirect to '/puppies'
end

get '/puppies' do
  @puppies = PuppyBreeder.puppy_repo_instance.log
  # breeds = @puppies.map { |x| x.breed }.uniq
  # puppy_list = {}
  # puppies.each do |puppy|
    # puppy_list[puppy.breed][:available_puppies] << puppy
  # end
  # @puppy_list = puppy_list.map { |key, val| val[:available_puppies] }.flatten
  erb :puppies
end

get '/request' do
  @puppies = PuppyBreeder.puppy_repo_instance.log
  @breeds = @puppies.map { |x| x.breed }.uniq
  # puppies = PuppyBreeder.puppy_repo_instance.log
  # puppy_list = {}
  # puppies.each do |puppy|
  #   puppy_list[puppy.breed][:available_puppies] << puppy
  # end
  # @puppy_list = puppy_list.map { |key, val| val[:available_puppies] }.flatten
  erb :request
end

post '/request' do
  request = PuppyBreeder::Request.new(params["breed"])
  PuppyBreeder.request_repo_instance.add_request(request)
  redirect to '/requests'
end

get '/requests' do
  @request_list = PuppyBreeder.puppy_repo_instance.log
  # puppy_list = Hash.new(0)
  # puppies.each do |puppy|
  #   puppy_list[puppy.breed][:available_puppies] << puppy
  # end
  # @puppy_list = puppy_list.map { |key, val| val[:available_puppies] }.flatten
  # binding.pry
  erb :requests
end
