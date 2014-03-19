require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'

describe 'Project' do
  before do
    @new_project = TM::Project.new("New Project")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with a name" do
    result = @new_project.name
    expect(result).to eq("New Project")
  end

  it "initializes with an id number that is readable" do
    expect { @new_project.id}.to_not raise_error
  end

  it "can add tasks to a project" do
    test_task = TM::Task.new(1, "add a task", 1)
    @new_project.add_task(test_task)
    expect(@new_project.tasks.first).to eq(test_task)
  end

  it "can change task status to complete" do
    test_task = TM::Task.new(1, "add a task", 1)
    @new_project.add_task(test_task)
    @new_project.complete(2)
    expect(@new_project.tasks.first.status).to eq("completed")
  end

  it "has a #retrieve_completed that will generate a list of completed tasks" do
    test_task = TM::Task.new(1, "add a task", 1, "completed")
    test_task2 = TM::Task.new(1, "add a new task", 1, "completed")
    test_task3 = TM::Task.new(1, "add a task", 1)
    @new_project.add_task(test_task)
    @new_project.add_task(test_task2)
    @new_project.add_task(test_task3)
    result = @new_project.retrieve_completed
    expect(result).to eq([test_task, test_task2])
  end

  it "sorts completed tasks by creation date (task_id)" do
    test_task = TM::Task.new(1, "add a task", 1, "completed")
    test_task2 = TM::Task.new(1, "add a new task", 1, "completed")
    test_task3 = TM::Task.new(1, "add a task", 1, "completed")
    @new_project.add_task(test_task2)
    @new_project.add_task(test_task3)
    @new_project.add_task(test_task)
    result = @new_project.retrieve_completed
    expect(result).to eq([test_task, test_task2, test_task3])
  end


end

