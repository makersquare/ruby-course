require 'spec_helper'
require 'pry-debugger'

describe 'Task' do
  
  before(:each) do
    TM::Task.reset_class_variables
    @t1 = TM::Task.new(1, 'Task 1', 1)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "A new task can be created with a project id, description, and priority number." do
    expect(@t1.tid).to eq(1)
    expect(@t1.description).to eq("Task 1")
    expect(@t1.pnum).to eq(1)
  end
end
