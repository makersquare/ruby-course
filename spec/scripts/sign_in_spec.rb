require 'spec_helper'

describe Honkr::SignIn do

  before do
    @user = Honkr::User.new(99, "alice")
    @user.update_password("my password")

    # Stub the database to return a user; we're testing this TxS, not the database code
    expect(Honkr.db).to receive(:get_user_by_username).and_return(@user)
  end

  it "creates a session for an existing user" do
    expect(Honkr.db).to receive(:create_session).with(:user_id => @user.id).and_return("my session id")

    result = Honkr::SignIn.run(:username => "alice", :password => "my password")
    expect(result[:success?]).to eq true
    expect(result[:session_id]).to eq "my session id"
  end

  it "requires the correct password" do
    result = Honkr::SignIn.run(:username => "alice", :password => "diff password")
    expect(result[:success?]).to eq false
    expect(result[:error]).to eq :invalid_password
  end

end
