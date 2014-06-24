require 'spec_helper.rb'

describe Honker::User do

  describe "initialize" do
    it "initializes a username and password_digest" do

      pending "You need to implement password hashing first"
      # TODO: Hash password
      # password_digest = ???.??("joe's password")
      user = Honker::User.new(55, "joe", password_digest)

      expect(user.id).to eq(55)
      expect(user.username).to eq("joe")

      expect(user.has_password? "joe's password").to eq true
    end
  end
end
