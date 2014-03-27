require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'
require './lib/task-manager/database.rb'

describe "Database" do
  before do
    @db = TM.db
  end

  it "can create a new project with add_project" do
    result = @db.create_project("New Project 1")
    expect(result.class).to eq(TM::Project)
  end

  it "can create a new task" do
    # project = TM::Project.new("Chemistry")
    project = @db.create_project("Chemistry")
    # task = TM::Task.new("new task", project.id, 3)
    task = @db.add_project_task("new task", project.id, 3)
    expect(@db.tasks[task.id].description).to eq("new task")
  end

  it "can change task status to completed" do
    project = @db.create_project("Chemistry")
    # test_task = TM::Task.new(1, "new task", 1)
    task = @db.add_project_task("new task", project.id, 1)
    task = @db.task_completed(task.id)
    expect(task.status).to eq(true)
  end

  it "can retrieve a list of all completed tasks" do
    project = @db.create_project("Chemistry")
    task1 = @db.add_project_task("new task 1", project.id, 1)
    task2 = @db.add_project_task("new task 2", project.id, 2)
    task3 = @db.add_project_task("new task 3", project.id, 3)

    @db.task_completed(task1.id)
    @db.task_completed(task2.id)
    expect(@db.retrieve_completed).to eq([task1, task2])
  end

  it "can sort completed tasks by creation date" do
    project = @db.create_project("Mathematics")
    task2 = @db.add_project_task("new task 1", project.id, 1)
    task1 = @db.add_project_task("new task 2", project.id, 2)
    task3 = @db.add_project_task("new task 3", project.id, 3)

    @db.task_completed(task1.id)
    @db.task_completed(task2.id)
    expect(@db.retrieve_completed).to eq([task2, task1])
  end

  it "can sort incomplete tasks by priority" do
    project = @db.create_project("Biology")
    task2 = @db.add_project_task("new task 1", project.id, 1)
    task1 = @db.add_project_task("new task 2", project.id, 2)

    expect(@db.retrieve_incomplete).to eq([task2, task1])
  end

  it "can sort incomplete tasks by creation date if priority is same" do
    project = @db.create_project("Mathematics")
    task2 = @db.add_project_task("new task 1", project.id, 1)
    task1 = @db.add_project_task("new task 2", project.id, 1)
    task3 = @db.add_project_task("new task 3", project.id, 1)

    expect(@db.retrieve_incomplete).to eq([task2, task1, task3])
  end



end
