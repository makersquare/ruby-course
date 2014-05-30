require 'spec_helper'

describe 'Creating an Employee Account' do

  it "can create an employee account" do
    # Given that I have an admin account
    admin = DoubleDog.db.create_user(:username => 'alice', :password => '123', :admin => true)

    # And I am signed in
    signin_result = DoubleDog::SignIn.new.run(:username => 'alice', :password => '123')
    expect(signin_result[:success?]).to eq true
    session_id = signin_result[:session_id]

    # When I create an employee account for Bob
    create_result = DoubleDog::CreateAccount.new.run(
      :session_id => session_id,
      :username => 'bob',
      :password => 'xyz'
    )
    expect(create_result[:success?]).to eq true

    # The account should not be an admin
    employee = create_result[:user]
    expect(employee.admin?).to eq false
  end
end
