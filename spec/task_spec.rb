require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "has a task id" do
    project = TM::Project.new("Project 1")
    task_1 = TM::Task.new(0, "Find clients", 5)
    task_2 = TM::Task.new(0, "Sell books", 5)
    expect(task_2.id).to eq(1)
  end

  it "has a project id" do
    project_1 = TM::Project.new("Project 1")
    project_2 = TM::Project.new("Project 2")
    task_1 = TM::Task.new(1, "Find clients", 5)
    expect(task.project_2.id).to eq(1)
  end

  it "has a creation date" do
    task_1 = TM::Task.new(1, "Find clients", 5)
    expect(task_1.creation_date).to eq(Date.today)
  end

  it "can be marked as complete specified by task id" do
    task_1 = TM::Task.new(1, "Find clients", 5)
    expect(task_1.complete).to eq(true)    
  end


end

# (p_id, description, priority_number)


# task created with

#   unique id
#   project id
#   description
#   priority number

# can be 

#   marked as complete
#     specify by id

project can retrieve

  list of complete tasks
    sort by creation date

  list of incomplete tests
    sort by priority number

