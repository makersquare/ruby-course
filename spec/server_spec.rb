require 'server_spec_helper'

describe Songify::Server do
	
	def app
		Songify::Server.new
	end
	
end