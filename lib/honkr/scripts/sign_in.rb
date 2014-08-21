module Honkr
  class SignIn

    def self.run(params)
      if params[:username].empty? || params[:password].empty?
        return {:success? => false, :error => "BLANK ENTRIES"}
      end

      user = Honkr.db.get_user_by_username(params[:username])
      return {:success? => false, :error => "NO SUCH USER"} if !user

      if !user.has_password?(params[:password])
        return {:success? => false, :error => :invalid_password}
      end

      session_id = Honkr.db.create_session(user_id: user.id)
      
      {
        :success? => true,
        :session_id => session_id #user.id
      }    
        
    end

  end
end
