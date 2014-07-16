require 'spec_helper'

describe DoubleDog::SignIn do
  describe 'validation' do
    it "requires a non-nil username" do
      script = DoubleDog::SignIn.new
      result = script.run(username: nil)

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:nil_username)
    end

    it "requires a non-blank username" do
      script = DoubleDog::SignIn.new
      result = script.run(username: '')

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:blank_username)
    end

    it "it requires a non-nil password" do
      script = DoubleDog::SignIn.new
      result = script.run(username: 'bob_man', password: nil)

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:nil_password)
    end

    it "it requires a non-blank password" do
      script = DoubleDog::SignIn.new
      result = script.run(username: 'malice_alice', password: '')

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:blank_password)
    end

    it "requires the username to exist" do
      script = DoubleDog::SignIn.new
      result = script.run(:username => "doesn't exist", :password => "doesn't exist")

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:no_such_user)
    end

    it "requires the password to match the username" do
      user = DoubleDog.db.create_user(username: 'sally', password: 'brownie')
      script = DoubleDog::SignIn.new
      result = script.run(:username => user.username, :password => 'pillsbury')

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:invalid_password)
    end
  end

  it "creates a sessions for the user" do
    user = DoubleDog.db.create_user(username: 'alice', password: 'beer')
    script = DoubleDog::SignIn.new
    result = script.run(:username => user.username, password: 'beer')

    expect(result[:success?]).to eq(true)

    session_id = result[:session_id]

    expect(user.username).to eq('alice')
    expect(session_id).to_not be_nil
  end

  it "retrieves a user from the created session" do
    user = DoubleDog.db.create_user(username: 'bob', password: 'pass12')
    script = DoubleDog::SignIn.new
    result = script.run(:username => user.username, password: 'pass12')

    expect(result[:success?]).to eq(true)

    user = result[:user]
    expect(user.username).to eq('bob')
  end
end
