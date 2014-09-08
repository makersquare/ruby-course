require_relative 'lib/puppy_breeder.rb'
require 'sinatra'
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
  PuppyBreeder.puppy_repo_instance.add_puppy(puppy)
  redirect to '/puppies'
end

get '/puppies' do
  @available_counter = 1
  @available_list = PuppyBreeder.puppy_repo_instance.show_puppies
  @hold_counter = 1
  @hold_list = PuppyBreeder.puppy_repo_instance.show_held_puppies
  @sold_counter = 1
  @sold_list = PuppyBreeder.puppy_repo_instance.show_sold_puppies
  erb :puppies
end

get '/request' do
  @puppies = PuppyBreeder.puppy_repo_instance.log
  @breeds = @puppies.map { |x| x.breed }.uniq
  erb :request
end

post '/request' do
  request = PuppyBreeder::Request.new(params["breed"])
  PuppyBreeder.request_repo_instance.add_request(request)
  redirect to '/requests'
end

get '/requests' do
  @pending_list = PuppyBreeder.request_repo_instance.show_pending_requests
  @hold_list = PuppyBreeder.request_repo_instance.show_hold_requests
  @approved_list = PuppyBreeder.request_repo_instance.show_approved_requests
  @denied_list = PuppyBreeder.request_repo_instance.show_denied_requests
  erb :requests
end
