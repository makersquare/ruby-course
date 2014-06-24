module Honker
  class User

    attr_reader :id, :username, :password_digest

    def initialize(id, username, password_digest)
      @id = id
      @username = username
      @password_digest = password_digest
    end

    def has_password?(password)
      # TODO: Hash incoming password and compare against own password_digest
    end
  end
end
