require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'

describe 'Project' do
  before do
    @new_project = TM::Project.new("New Project Name")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes and has a project name" do
    result = @new_project.name
    expect(result).to eq("New Project Name")
  end

  it "initializes with an id" do
    result = @new_project.id
    expect(result.class).to eq(Fixnum)
  end

  it "can add tasks to a project" do
    test_task = TM::Task.new(1, "new task", 5)
    @new_project.add_task(test_task)
    expect(@new_project.tasks.last).to eq(test_task)
  end

  it "can change task status to completed" do
    test_task = TM::Task.new(1, "new task", 1)
    @new_project.add_task(test_task)
    task = @new_project.task_completed(test_task.id)
    expect(task.status).to eq("completed")
  end

  it "can retrieve a list of all completed tasks" do
    task1 = TM::Task.new(1, "new task 1", 1, "completed")
    task2 = TM::Task.new(2, "new task 1", 2, "completed")
    task3 = TM::Task.new(3, "new task 2", 3)
    @new_project.add_task(task1)
    @new_project.add_task(task2)
    @new_project.add_task(task3)
    expect(@new_project.retrieve_completed).to eq([task1, task2])
  end

  it "can sort completed tasks by creation date" do
    task1 = TM::Task.new(1, "new task 1", 1, "completed")
    task2 = TM::Task.new(2, "new task 1", 2, "completed")
    task3 = TM::Task.new(3, "new task 2", 3, "completed")
    @new_project.add_task(task3)
    @new_project.add_task(task2)
    @new_project.add_task(task1)
    expect(@new_project.retrieve_completed).to eq([task1, task2, task3])
  end

  it "can sort incomplete tasks by priority" do
    task1 = TM::Task.new(1, "new task 1", 1)
    task2 = TM::Task.new(2, "new task 1", 2)
    task3 = TM::Task.new(3, "new task 2", 3)
    @new_project.add_task(task1)
    @new_project.add_task(task2)
    @new_project.add_task(task3)
    expect(@new_project.retrieve_incomplete).to eq([task1, task2, task3])
  end

  it "can sort incomplete tasks by creation date if priority is same" do
    task1 = TM::Task.new(1, "new task 1", 1)
    task2 = TM::Task.new(2, "new task 2", 2)
    task3 = TM::Task.new(3, "new task 3", 2)
    task4 = TM::Task.new(3, "new task 4", 1)
    @new_project.add_task(task1)
    @new_project.add_task(task2)
    @new_project.add_task(task3)
    @new_project.add_task(task4)
    expect(@new_project.retrieve_incomplete).to eq([task1, task4, task2, task3])
  end

end
