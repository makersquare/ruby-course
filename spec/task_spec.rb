require 'spec_helper'

describe 'Task' do
  it "Task exists" do
    expect(TM::Task).to be_a(Class)
  end


  it "Tasks should have a default description of 'no description'." do
    newtask = TM::Task.new("Fix All Bugs")
    expect(newtask.description).to eq("no description")
  end
  it "Tasks should have a default priority of '1'." do
    newtask = TM::Task.new("Finish Everything")
    expect(newtask.priority).to eq(1)
  end


end
