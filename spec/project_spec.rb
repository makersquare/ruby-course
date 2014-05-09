require 'spec_helper'

describe 'Project' do

  before(:each) do
    TM::Project.reset_class_variables
    @p1 = TM::Project.new("p1")
    @p2 = TM::Project.new("p2")
  end

  let(:p1) { TM::Project.new("p1") }

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with a name" do
    expect(@p1).to be_a(TM::Project)
    expect(@p1.name).to eq("p1")
  end

  it "initializes with a unique id" do
    expect(@p1.id).to eq(1)
    expect(@p2.id).to eq(2)
  end

end
