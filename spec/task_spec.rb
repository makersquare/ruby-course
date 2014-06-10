require 'spec_helper'

describe 'Task' do

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before do
    project_1 = TM::Project.new("Project 1")
    project_2 = TM::Project.new("Project 2")
    task_1 = TM::Task.new(0, "Find clients", 5)
    task_2 = TM::Task.new(0, "Sell books", 5)
  end

  it "has a task id" do
    expect(task_2.task_id).to eq(1)
  end

  it "has a project id" do
    expect(task.project_2.project_id).to eq(1)
  end

  it "has a creation date" do
    expect(task_1.creation_date).to eq(Date.today)
  end

  it "has a default completion status of 'incomplete'" do
    expect(task_1.status).to eq("incomplete")
  end

  it "has task objects stored in a tasks array" do
    expect(task.tasks_list.size).to eq(1)
  end

  it "can be marked as complete specified by task id" do
    project_1.complete(1)
    expect(task_1.status).to eq("completed")    
  end

end