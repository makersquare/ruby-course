require 'sinatra'
require 'sinatra/reloader'
require 'eventmachine'
require 'json'
require 'pry-byebug'

require './lib/chatitude'

class Chatitude::Server < Sinatra::Application
  
  # use thin instead of webrick
  configure do
    set server: 'thin'
  end
  
  # helpers for connecting to db and prerparing json responses
  helpers do
    def db
      Chatitude.create_db_connection 'blogtastic'
    end

    def timestamp
      Time.now.strftime("%H:%M:%S")
    end

    def respond sender, message
      {
        :sender    => sender,
        :message   => message,
        :timestamp => timestamp
      }.to_json
    end

    def parse_message input
      msg_pieces = input.split
      data = {sender: @current_user['username']}
      if msg_pieces.first == '/pm'
        data.merge({
          :recipient => msg_pieces[1],
          :message   => msg_pieces[2..-1].join(' ')
        })
      else
        data.merge({
          :recipient => :all,
          :message   => input
        })
      end
    end
  end

  # run this before every endpoint to get the current user
  before do
    if session[:user_id]
      @current_user = Chatitude::UsersRepo.find db, session[:user_id]
    end
  end

  # Array used to store event streams
  connections = []


  ############ MAIN ROUTES ###############

  get '/' do
    erb :index
  end

  post '/signup' do
    if params[:password] == params[:password_confirmation]
      user_data = {username: params[:username], password: params[:password]}
      user = Chatitude::UsersRepo.save db, user_data
      session[:user_id] = user['id']
      {action: 'signup', success: true}.to_json
    end
  end

  post '/signin' do
    user = Chatitude::UsersRepo.find_by_name db, params[:username]

    if user && user['password'] == params[:password]
      session[:user_id] = user['id']
      {action: 'signin', success: true}.to_json
    end
  end

  get '/logout' do
    session.delete('user_id')
    redirect to '/'
  end

  ##########################################
  # event stream stuff.

  # this endpoint is where the user goes in the
  # browser to see incoming messages.
  get '/chat', provides: 'text/event-stream' do
    if @current_user
      stream :keep_open do |out|
        def out.user; @current_user; end
        connections << out
        out.callback { connections.delete(out) }
      end
    else
      redirect to 'sign'
    end
  end
  
  # this endpoint is where messages are sent to.
  post '/chat' do
    sender = @current_user['username']
    input  = parse_message params[:chat_message]
    if input[:recipient] == :all
      connections.each { |out| out << respond(sender, params[:chat_message]) }
    else
      rconn = connections.find { |out| out.user['username'] == input[:recipient] }
      rconn << respond(input[:sender], input[:message]) if rconn
    end
  end

  # possibly not needed?
  # post '/chatping' do
  #   if params[:ping]
  #     conn = connections.find { |out| out.user == @current_user['id'] }
  #     conn << "PONG"
  #   end
  # end
end
