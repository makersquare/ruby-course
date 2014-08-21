module Honkr
  class SignIn

    def self.run(params)
      # TODO
      if params[:username].empty? || params[:password].empty?
        return {:success? => false, :error => "Please fill out all input fields."}
      end

      user = Honkr.db.get_user_by_username(params[:username])
      if !user
        return {:success? => false, :error => "User not found."}
      end

      if !user.has_password?(params[:password])
        return {:success? => false, :error => :invalid_password}
      end

      session = Honkr.db.create_session(:user_id => user.id)

      {
        :success? => true,
        :session_id => session
      }

    end

  end
end
