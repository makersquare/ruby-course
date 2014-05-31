require 'spec_helper'

describe DoubleDog::User do

  describe '#total?' do
    it "returns the total for an order" do
      item1 = DoubleDog::Item.new(nil, 'burger', 18)
      item2 = DoubleDog::Item.new(nil, 'fries', 2)

      order = DoubleDog::Order.new(nil, nil, [item1, item2])
      expect(order.total).to eq 20
    end
  end

end
