require 'sinatra'
require 'sinatra/reloader'
require 'eventmachine'
require 'json'
require 'pry-byebug'

require './lib/chatitude'

class Chatitude::Server < Sinatra::Application
  configure do
    set server: 'thin'
  end
  
  helpers do
    def db
      Chatitude.create_db_connection 'blogtastic'
    end

    def timestamp
      Time.now.strftime("%H:%M:%S")
    end
  end
  
  connections = []
 
  before do
    if session[:user_id]
      @current_user = Chatitude::UsersRepo.find db, session[:user_id]
    end
  end

  ############ MAIN ROUTES ###############

  get '/' do
    erb :index
  end
  
  ########### SESSION STUFF ##############

  get '/signup' do
  end
  
  get '/signin' do
  end
  
  post '/signup' do
    if params[:password] == params[:password_confirmation]
      user_data = {username: params[:username], password: params[:password]}
      user = Chatitude::UsersRepo.save db, user_data
      session[:user_id] = user['id']
      redirect to '/posts' # no redirect
    end
  end
  
  post '/signin' do
    user = Chatitude::UsersRepo.find_by_name db, params[:username]

    if user && user['password'] == params[:password]
      session[:user_id] = user['id']
      redirect to '/posts' # no redirect
    end
  end

  get '/logout' do
    session.delete('user_id')
    redirect to '/posts'
  end

  ##########################################
  # event stream stuff.

  # this endpoint is where the user goes in the
  # browser to see incoming messages.
  get '/chat', provides: 'text/event-stream' do
    stream :keep_open do |out|
      # EventMachine::PeriodicTimer.new(20) { out << '\0' } # keep connection open
      def out.user; @current_user['id']; end
      connections << out
      out.callback { connections.delete(out) }
    end
  end
  
  # this endpoint is where messages are sent to.
  post '/chat' do
    sender  = @current_user['username']
    message = params[:chat_message]
    connections.each { |out| out << "#{timestamp} #{sender}: #{message}\n"}
  end

  post '/chatping' do
    if params[:ping]
      conn = connections.find { |out| out.user == @current_user['id'] }
      conn << "PONG"
    end
  end
end
