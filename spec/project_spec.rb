require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe 'initialize' do
    it "creates a new project with a name" do
      project1 = TM::Project.new("Grades")

      expect(project1.name).to eq("Grades")
    end

    it "gives a new project a unique id" do
      project1 = TM::Project.new("Grades")
      expect(project1.id).to_not raise_error()
    end

    it "creates an empty tasks array to store project tasks" do
      project1 = TM::Project.new("Grades")
      expect(project1.tasks).to eq([])
    end
  end

  describe 'add_task' do
    it "adds a task object to the tasks array" do
      project1 = TM::Project.new("Grades")
      project1.add_task(TM::Task.new("Create gradebook", project1.id, 1))

      expect(project1.tasks.length).to eq(1)
    end
  end

  describe 'mark_complete' do

    it "has a mark_complete method" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      t_id = task.task_id
      expect(project1.mark_complete(t_id)).to_not raise_error()
    end

    it "marks a task's status as complete" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      project1.add_task(task)
      t_id = task.task_id
      project1.mark_complete(t_id)
      expect(task.status).to eq("Completed")
    end
  end

  describe 'completed_tasks' do
    it "returns an array/list of all completed tasks in the project" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      task2 = TM::Task.new("Add students", project1.id, 2)
      task3 = TM::Task.new("Add tests", project1.id, 3)

      project1.add_task(task)
      project1.add_task(task2)
      project1.add_task(task3)

      project1.mark_complete(task.task_id)
      project1.mark_complete(task2.task_id)

      expect(project1.completed_tasks.length).to eq(2)
    end

    it "returns a list of completed tasks that are sorted by creation date" do
      project1 = TM::Project.new("Grades")
      task = TM::Task.new("Create gradebook", project1.id, 1)
      allow(Date).to receive(:today).and_return(Date.parse("14 Feb 2014"))
      task2 = TM::Task.new("Add students", project1.id, 2)
      allow(Date).to receive(:today).and_return(Date.parse("14 March 2014"))
      task3 = TM::Task.new("Add tests", project1.id, 3)
      allow(Date).to receive(:today).and_return(Date.parse("14 March 2012"))
      task4 = TM::Task.new("Add tests", project1.id, 4)

      project1.add_task(task)
      project1.add_task(task2)
      project1.add_task(task3)

      project1.mark_complete(task.task_id)
      project1.mark_complete(task2.task_id)
      project1.mark_complete(task3.task_id)

      expect(project1.completed_tasks).to eq([task2, task3, task])
    end
  end
end
