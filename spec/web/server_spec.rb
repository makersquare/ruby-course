require 'server_spec_helper'

describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /" do
    it "Loads the homepage. Displays all songs in db" do

      get '/'
      expect(last_repsponse.body).to include "Songify"
    end
  end
  
  describe "POST /" do
    it "Creates a new song. Adds to DB."

    end
  end
end