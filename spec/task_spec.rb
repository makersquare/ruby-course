require 'spec_helper'

describe 'Task' do
 #   before(:each) do
 #   new_task = TM::Task.new("Write Spec")
 # end


  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initalizes with a description" do
    new_task = TM::Task.new("Write Spec")
    expect(new_task.description).to eq("Write Spec")

  end

  it "intializes with the correct time stamp" do
     @created = Time.parse("Feb 24 1981")
    Time.stub(:now).and_return(@created)
  end

  it "initalizes with a time created" do
    task_one = TM::Task.new("Another Task")
    expect(task_one.created).to be_truthy
  end

  xit "initalizes with as default priority of 1" do
  end

  xit "intializes with a state of not complete" do
  end

  xit "it can be marked complete" do
  end

  xit "it's description can be changed" do
  end

  xit "it's priority can be changed" do
  end

end
