module Honkr
  class User

    attr_reader :id, :username, :password_digest

    def initialize(id, username, password_digest=nil)
      @id = id
      @username = username
      @password_digest = password_digest
    end

    def update_password(password)
      @password = password
      @password_digest = Digest::SHA1.hexdigest(password)
    end

    def has_password?(password)
      if @password_digest == Digest::SHA1.hexdigest(password)
        true
      end
    end
  end
end
