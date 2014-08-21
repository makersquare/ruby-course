module Honkr
  class SignIn

  	attr_reader :result

    def self.run(params)
      user = Honkr.db.get_user_by_username(params[:username])
      # @result = {}
      # @params = params
      # @username = params[:username]
      # @password = params[:password]
      # Databases.InMemory.get_user(@params)
      # user = Honkr.db.get_user_by_username(@username)
      if !user.has_password?(params[:password])
      	return {success?: false, error: :invalid_password}
      	# @result[:session_id] = Honkr.db.create_session(:user_id => user.id)
      	# @result[:success?] = true
      	# return @result
      # else
  	  end

  	  session = Honkr.db.create_session(:user_id => user.id)
  	  {
  	  	success: true,
  	  	session_id: session)
  	  }

      	# @result[:error] = :invalid_password
      	# @result[:success?] = false
      	# @result
      end
    end

  end
end
