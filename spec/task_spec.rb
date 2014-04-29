require 'spec_helper'
require 'pry-debugger'

 describe 'Project' do
    it "exists" do
      expect(TM::Project).to be_a(Class)
    end

    it "allows a new project to be created with a name" do
      shopping = TM::Project.new("Shopping")
      expect(shopping.name).to eq("Shopping")
      expect(shopping.pid).to eq(1)
    end
end


describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "A new task can be created with a project id, description, and priority number." do
    buy_shoes = TM::Task.new(1,"Buy a new pair of shoes",1)
    expect(buy_shoes.tid).to eq(1)
    expect(buy_shoes.description).to eq("Buy a new pair of shoes")
    expect(buy_shoes.pnum).to eq(1)
  end

  # xit "A new task can be complete, specified by id" do
end
