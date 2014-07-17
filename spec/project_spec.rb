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

  it "can retrieve a list of completed tasks by date created" do
    # Time.stub(:now).and_return(Time.parse("5:00 PM"))

  end

  it "can retrieve a list of incomplete tasks sorted by priority number" do

  end

end
