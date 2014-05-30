module DoubleDog
  class SignIn

    def run(params)
    end

  private

    def failure(error_name)
      return :success? => false, :error => error_name
    end
  end
end
