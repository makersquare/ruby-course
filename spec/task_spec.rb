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

  it "limits priority to between 1 and 5" do
    new_task = TM::Task.new(4, "errands", 10)
    expect(new_task.priority).to eq(5)
    another_task = TM::Task.new(3, "stuff", 0)
    expect(another_task.priority).to eq(1)
  end

  it "initializes as an incomplete task" do
    expect(@my_task.complete?).to eq (false)
  end

  it "initializes tasks with a creation date" do
    present = Time.now
    Time.stub(:now).and_return(present)
    new_task = TM::Task.new(4, "Tasks today", 1)
    expect(new_task.created).to eq(present)
  end

  it "can mark tasks as complete" do
    expect(@my_task.mark_comp).to eq (true)
  end

  it "can mark tests as incomplete" do
    expect(@my_task.mark_inc).to eq (false)
  end

end
