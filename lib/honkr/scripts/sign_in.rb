module Honkr
  class SignIn

    def self.run(params) # :username => "alice", :password => "my password"
      # TODO creates a session for an existing user
      user = Honkr.db.get_user_by_username(:username => params[:username])

      # TODO requires the correct password
      if user.has_password?(params[:password])
        session_id = Honkr.db.create_session(:user_id => user.id)

        { :success? => true, :session_id => session_id }
      else
        { :success? => false, :error => :invalid_password }
      end
    end
  end
end
