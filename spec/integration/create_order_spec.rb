require 'spec_helper'

describe 'Creating an Order' do

  it "can create an order with selected items" do
    # Given that I have an employee account
    admin = DoubleDog.db.create_user(:username => 'bob', :password => 'xyz')

    # And I am signed in
    signin_result = DoubleDog::SignIn.new.run(:username => 'bob', :password => 'xyz')
    expect(signin_result[:success?]).to eq true
    session_id = signin_result[:session_id]

    # And there are several items
    item1 = DoubleDog.db.create_item(:name => 'Smoothie', :price => 5)
    item2 = DoubleDog.db.create_item(:name => 'Roughie', :price => 97)
    item3 = DoubleDog.db.create_item(:name => 'Juice', :price => 7)

    # When I create an order
    create_result = DoubleDog::CreateOrder.new.run(
      :session_id => session_id,
      :items => [item1, item2, item3]
    )
    expect(create_result[:success?]).to eq true

    # I should see the total
    order = create_result[:order]
    expect(order.total).to eq 109
  end
end
