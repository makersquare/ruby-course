require 'spec_helper'

describe 'Project' do

  before(:each) do # has these happen so I don't keep writing them in
    TM::Project.reset_class_variables
    @project_1 = TM::Project.new("p1")
    @project_2 = TM::Project.new("p2")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end
  it "initializes with a name" do
    expect(@project_1).to be_a(TM::Project)
    expect(@project_1.name).to eq("p1")
  end

  it "initializes with a unique id" do
    expect(@project_1.id).to eq(1)
    expect(@project_2.id).to eq(2)
  end

end


