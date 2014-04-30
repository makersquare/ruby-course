require 'spec_helper'

describe 'Project' do

  before(:each) do
    @@id_counter = 0
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "allows a new project to be created with a name" do
      shopping = TM::Project.new("Shopping")
      expect(shopping).to be_a(TM::Project)
      expect(shopping.name).to eq("Shopping")
  end

  it "initializes with a unique id" do
  	p1 = TM::Project.new("Project 1")
  	p2 = TM::Project.new("Project 2")
  	expect(p1.pid).to eq(1)
  	expect(p2.pid).to eq(2)
  end
end
