require 'spec_helper'

describe 'Task' do

  before do
    @my_task = TM::Task.new(4, "Tasks today", 1)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes with project ID, description, and priority" do
    expect(@my_task.projID).to eq(4)
    expect(@my_task.description).to eq("Tasks today")
    expect(@my_task.priority).to eq(1)
  end

  it "initializes as an incomplete task" do
    expect(@my_task.complete).to eq ("incomplete")
  end

end
