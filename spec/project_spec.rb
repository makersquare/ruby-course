require 'spec_helper'


describe 'Project' do
# this says before every test run this code
# making these instance variables gives their scope a larger access
  before(:each) do
    TM::Project.reset_class_variables
    @p1 = TM::Project.new("project1")
    @p2 = TM::Project.new("project2")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with a name" do
    # project1 = TM::Project.new("Bobby")
    expect(@p1).to be_a(TM::Project)
    expect(@p1.name).to eq("project1")
  end

  it "has an id" do
    expect(@p1.id).to eq(1)
    expect(@p2.id).to eq(2)
  end

  # it "has a description" do
  #   expect(@p1.description).to eq("Monday")
  #   expect(@p2.description).to eq("To Do")
  # end

  # it "changes priorty number" do
  #   @p1.change_priority(5)
  #   expect(@p1.change_priority).to eq(5)
  # end

end
