require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'
require './lib/task-manager/database.rb'

describe "Database" do
  before do
    @db = TM.db
  end

  it "can create a new project with add_project" do
    result = @db.add_project("New Project 1")
    expect(result.class).to eq(TM::Project)
  end

  it "can add task to a project" do
    test_task = TM::Task.new("new task", 7, 3)
    @db.add_task(test_task)
    expect(@db.tasks[test_task.id]).to eq(test_task)
  end

  # xit "can add a new task to a project" do
  #   @db.add_project("New Project 2")
  #   task_object = @db.add_new_task("Chemistry HW", 2, 3)
  #   result = @db.projects.last.tasks[1]
  #   expect(result).to eq(task_object)
  # end

  it "can change task status to completed" do
    test_task = TM::Task.new(1, "new task", 1)
    @db.add_task(test_task)
    task = @db.task_completed(test_task.id)
    expect(task.status).to eq(true)
  end

  it "can retrieve a list of all completed tasks" do
    task1 = TM::Task.new(1, "new task 1", 1)
    task2 = TM::Task.new(2, "new task 1", 2)
    task3 = TM::Task.new(3, "new task 2", 3)
    @db.add_task(task1)
    @db.add_task(task2)
    @db.add_task(task3)
    @db.task_completed(task1.id)
    @db.task_completed(task2.id)
    expect(@db.retrieve_completed).to eq([task1, task2])
  end

  it "can sort completed tasks by creation date" do
    task1 = TM::Task.new(1, "new task 1", 1)
    task2 = TM::Task.new(2, "new task 1", 2)
    task3 = TM::Task.new(3, "new task 2", 3)
    @db.add_task(task3)
    @db.add_task(task2)
    @db.add_task(task1)
    @db.task_completed(task1.id)
    @db.task_completed(task2.id)
    @db.task_completed(task3.id)
    expect(@db.retrieve_completed).to eq([task1, task2, task3])
  end

  it "can sort incomplete tasks by priority" do
    task1 = TM::Task.new(1, "new task 1", 1)
    task2 = TM::Task.new(2, "new task 1", 2)
    task3 = TM::Task.new(3, "new task 2", 3)
    @db.add_task(task1)
    @db.add_task(task2)
    @db.add_task(task3)
    expect(@db.retrieve_incomplete).to eq([task1, task2, task3])
  end

  it "can sort incomplete tasks by creation date if priority is same" do
    task1 = TM::Task.new(1, "new task 1", 1)
    task2 = TM::Task.new(2, "new task 2", 2)
    task3 = TM::Task.new(3, "new task 3", 2)
    task4 = TM::Task.new(3, "new task 4", 1)
    @db.add_task(task1)
    @db.add_task(task2)
    @db.add_task(task3)
    @db.add_task(task4)
    expect(@db.retrieve_incomplete).to eq([task1, task4, task2, task3])
  end



end
