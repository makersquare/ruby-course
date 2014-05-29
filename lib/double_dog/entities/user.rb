module DoubleDog
  class User
    attr_reader :id, :username

    def initialize(id, username, password)
      @id = id
      @username = username
      @password = password
    end

    def has_password?(pass)
      # Note: Storing passwords in plain text is NOT acceptable.
      # In practice, you will use bcrypt to securely store *hashes* of your user's passwords.
      @password == pass
    end
  end
end
