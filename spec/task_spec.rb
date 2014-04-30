require 'spec_helper'

describe 'Task' do

  before(:each) do
    TM::Task.reset_class_variables
    TM::Project.reset_class_variables
    @p1 = TM::Project.new("project1")
    @p2 = TM::Project.new("project2")
    @task1 = TM::Task.new(@task_id, "To Do", 2)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "has a task id" do
    expect(@task1.task_id).to eq(1)
  end

  it "has a description" do
    expect(@task1.description).to eq("To Do")
  end

  it "has a priority number" do
    expect(@task1.priority_number).to eq(2)
  end

  it "changes priority number" do
    @task1.change_priority(3)
    expect(@task1.priority_number).to eq(3)
  end

  it "task can be marked complete by id" do
    # expect(@task1.mark_complete(@task_id)).to eq(true)
    # Take a task id, change the task's status to complete
    # task =
    expect(@task1.complete_status).to eq(false)
    TM::Task.complete_task(@task1.task_id)
    expect(@task1.complete_status).to eq(true)

    # 1. Task that has status as not complete
    # 2. execute the method mark_complete
    # 3. test to make sure the the status is complete
  end

  # it "retrieves a list of completes tasks by completion date" do

  # end

  # it "retrieves list of incomplete tasks by priority number" do

  # end

  # it "puts older task first if priority numbers match with incomplete tasks" do

  # end

end
