require 'server_spec_helper'

describe Songify::Server do
  
  def app
    Songify::Server.new
  end

  describe "GET /" do
    it "loads the homepage" do
      get '/index'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Songify"
    end
  end

end