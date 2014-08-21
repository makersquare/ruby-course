require 'digest/sha1'

module Honkr
  class User

    attr_reader :id, :username, :password_digest

    def initialize(id, username, password_digest=nil)
      @id = id
      @username = username
      @password_digest = password_digest
    end

    def update_password(password)
      @password_digest = Digest::SHA1.hexdigest(password)
    end

    def has_password?(password)
      Digest::SHA1.hexdigest(password) == @password_digest
    end
  end
end
