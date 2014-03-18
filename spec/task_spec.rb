require 'spec_helper'

describe 'Task' do

  before do
    @my_task = TM::Task.new(4, "Tasks today", 1)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  xit "initializes with project ID, description, and priority" do
    expect(@my_task.projID).to eq(4)
    expect(@my_task.description).to eq("Tasks today")
    expect(@my_task.priority).to eq(1)
  end

  it "initializes as an incomplete task" do
    expect(@my_task.complete).to eq ("incomplete")
  end

  it "initializes tasks with a creation date" do
    present = Time.now
    Time.stub(:now).and_return(present)
    new_task = TM::Task.new(4, "Tasks today", 1)
    expect(new_task.created).to eq(present)
  end

end
