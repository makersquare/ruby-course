module DoubleDog
  class User
    attr_reader :id, :username

    def initialize(id, username, password, admin=false)
      @id = id
      @username = username
      @password = password
      @admin = admin
    end

    def has_password?(pass)
      # Note: Storing passwords in plain text is NOT acceptable.
      # In practice, you will use bcrypt to securely store *hashes* of your user's passwords.
      @password == pass
    end

    def admin?
      !!@admin
    end
  end
end
