require 'spec_helper'

describe DoubleDog::CreateOrder do

  describe 'validation' do
    it "requires an employee to be logged in" do
      script = DoubleDog::CreateOrder.new
      result = script.run(session_id: nil)

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:invalid_session)
    end

    it "requires items" do
      user = DoubleDog::User.new(1, 'bob', 'pass1')
      expect(DoubleDog.db).to receive(:get_user_by_session_id).and_return(user)
      script = DoubleDog::CreateOrder.new

      result = script.run(session_id: 'stubbed', items: nil)

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:no_items_ordered)
    end

    it "requires at least one item" do
      user = DoubleDog::User.new(1, 'bob', 'pass1')
      expect(DoubleDog.db).to receive(:get_user_by_session_id).and_return(user)
      script = DoubleDog::CreateOrder.new

      result = script.run(session_id: 'stubbed', items: [])

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:no_items_ordered)
    end

  end

  it "creates an order" do
    item_1 = DoubleDog.db.create_item(name: 'hot dog', price: 5)
    user = DoubleDog::User.new(1, 'bob', 'pass1')
    expect(DoubleDog.db).to receive(:get_user_by_session_id).and_return(user)
    script = DoubleDog::CreateOrder.new

    result = script.run(session_id: 'stubbed', items: [item_1])

    expect(result[:success?]).to eq(true)

    order = result[:order]
    expect(order.employee_id).to eq(user.id)
    expect(order.items.count).to be >= 1
  end
end
