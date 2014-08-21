require 'spec_helper.rb'

describe Honkr::User do

  describe "initialize" do
    it "initializes a username and password_digest" do
      user = Honkr::User.new(55, "joe")
      user.update_password("joe's password")

      expect(user.id).to eq(55)
      expect(user.username).to eq("joe")

      expect(user.has_password? "joe's password").to eq true
    end
  end
end
