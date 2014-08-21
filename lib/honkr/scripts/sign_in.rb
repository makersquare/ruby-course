module Honkr
  class SignIn

  	attr_reader :result

    def self.run(params)
      @result = {}
      @params = params
      @username = params[:username]
      @password = params[:password]
      # Databases.InMemory.get_user(@params)
      user = Honkr.db.get_user_by_username(@username)
      if user && user.has_password?(@password)
      	@result[:session_id] = Honkr.db.create_session(:user_id => user.id)
      	@result[:success?] = true
      	return @result
      else
      	@result[:error] = :invalid_password
      	@result[:success?] = false
      	@result
      end
    end

  end
end
