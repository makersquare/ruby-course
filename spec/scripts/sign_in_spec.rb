require 'spec_helper'

describe Honker::SignIn do

  before do
    pending "TODO: Hash password"
    # password_digest = ???.??("my password")
    user = Honker::User.new(99, "alice", password_digest)

    # Stub the database to return a user; we're testing this TxS, not the database code
    expect(Honker.db).to receive(:get_user_by_username).and_return(user)
  end

  it "creates a session for an existing user" do
    expect(Honker.db).to receive(:create_session).with(:user_id => user.id).and_return("my session id")

    result = Honker::SignIn.run(:username => "alice", :password => "my password")
    expect(result[:success?]).to eq true
    expect(result[:session_id]).to eq "my session id"
  end

end
