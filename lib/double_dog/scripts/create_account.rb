module DoubleDog
  class CreateAccount

    def run(params)
      return failure(:not_admin) unless admin_session?(params[:session_id])
      return failure(:invalid_username) unless valid_username?(params[:username])
      return failure(:invalid_password) unless valid_password?(params[:password])

      user = DoubleDog.db.create_user(:username => params[:username], :password => params[:password])
      return success(:user => user)
    end

    def admin_session?(session_id)
      user = DoubleDog.db.get_user_by_session_id(session_id)
      user && user.admin?
    end

    def valid_username?(username)
      username != nil && username.length >= 3
    end

    def valid_password?(password)
      password != nil && password.length >= 3
    end

  private

    def failure(error_name)
      return :success? => false, :error => error_name
    end

    def success(data)
      return data.merge(:success? => true)
    end
  end
end
