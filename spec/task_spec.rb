require 'spec_helper'

describe 'Task' do
   before(:each) do
    @new_task = TM::Task.new("Write Spec")
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initalizes with a description" do
    expect(@new_task.description).to eq("Write Spec")

  end

  xit "intializes with a time created" do
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
