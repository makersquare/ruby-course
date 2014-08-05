require 'sinatra'
require_relative 'lib/puppy.rb'
require_relative 'lib/request.rb'
require_relative 'lib/puppymill.rb'
require_relative 'lib/dbi.rb'

set :bind, '0.0.0.0'
set :port, 4568

get '/' do
  @breeds = DBI.dbi.get_all_breeds
  p @breeds
  erb :index
end

get '/puppies' do
  @breed = params[:breed]
  @status = params[:status]
  if @breed == 'all' && @status == 'all'
    @puppies = DBI.dbi.get_all_puppies
  elsif @breed == 'all'
    @puppies = DBI.dbi.get_puppies_by_status(@status)
  elsif @status == 'all'
    @puppies = DBI.dbi.get_puppies_by_breed(@breed)
  else
    @puppies = DBI.dbi.get_puppies_by_status_and_breed(@status, @breed)
  end
  erb :puppies
end

get '/requests' do
  @breed = params[:breed]
  @status = params[:status]
  if @breed == 'all' && @status == 'all'
    @requests = DBI.dbi.get_all_requests
  elsif @breed == 'all'
    @requests = DBI.dbi.get_requests_by_status(@status)
  elsif @status == 'all'
    @requests = DBI.dbi.get_requests_by_breed(@breed)
  else
    @requests = DBI.dbi.get_requests_by_status_and_breed(@status, @breed)
  end
  erb :requests
end

post '/newpuppy' do
  @breed = params['breed']
  @dob = params['dob']
  @name = params['name']
  @puppies = DBI.dbi.add_puppy_to_db(@name, @breed, @dob)
  erb :puppies
end

post '/newrequest' do
  @breed = params['breed']
  @dob = params['dob']
  @name = params['name']
  @requests = DBI.dbi.add_request_to_db(@name, @breed, @dob)
  erb :requests
end

get '/newbreed' do
  @breed = params['breed']



end


