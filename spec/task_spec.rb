require 'spec_helper'
require 'pry-debugger'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "A new task can be created with a project id, description, and priority number." do
    shoes = TM::Project.new("Shoes")
    buy_shoes = TM::Task.new(shoes.pid,"Buy a new pair of shoes",1)
    expect(buy_shoes.tid).to eq(1)
    expect(buy_shoes.description).to eq("Buy a new pair of shoes")
    expect(buy_shoes.pnum).to eq(1)
  end

  xit "A new task can be complete, specified by id" do
    shop = TM::Project.new("clothes")
    buy_shirts = TM::Task.new(shop.pid, "But a new shirt", 1)
    expect(buy_shirts.markTID).to eq(false)
  end
end
