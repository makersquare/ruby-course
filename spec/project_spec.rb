require 'spec_helper'
require 'pry-debugger'

describe 'Project' do

  before(:each) do
    TM::Project.reset_class_variables
    @project1 = TM::Project.new("Grades")
    @project2 = TM::Project.new("Tests")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "Stores a list of all created projects" do
    expect(TM::Project.projects.length).to eq(2)
  end

  it "returns a list of all created projects" do
    expect(TM::Project.projects).to eq([@project1, @project2])
  end

  describe 'initialize' do
    it "creates a new project with a name" do
      expect(@project1).to be_a(TM::Project)
      expect(@project1.name).to eq("Grades")
    end

    it "gives a new project a unique id" do
      expect(@project1.id).to eq(1)
      expect(@project2.id).to eq(2)
    end

    it "creates an empty tasks array to store project tasks" do
      expect(@project1.tasks).to eq([])
    end
  end

  describe 'add_task' do
    it "adds a task object to the tasks array" do
      @project1.add_task(TM::Task.new("Create gradebook", @project1.id, 1))

      expect(@project1.tasks.length).to eq(1)
    end
  end

  describe 'mark_complete' do

    before(:each) do
      @task = TM::Task.new("Create gradebook", @project1.id, 1)
    end

    it "has a mark_complete method" do
      t_id = @task.task_id
      expect(@project1.mark_complete(t_id)).to_not raise_error()
    end

    it "marks a task's status as complete" do
      @project1.add_task(@task)
      t_id = @task.task_id
      @project1.mark_complete(t_id)
      expect(@task.status).to eq("Completed")
    end
  end

  describe 'completed_tasks' do
    it "returns an array/list of all completed tasks in the project" do
      task = TM::Task.new("Create gradebook", @project1.id, 1)
      task2 = TM::Task.new("Add students", @project1.id, 2)
      task3 = TM::Task.new("Add tests", @project1.id, 3)

      @project1.add_task(task)
      @project1.add_task(task2)
      @project1.add_task(task3)

      @project1.mark_complete(task.task_id)
      @project1.mark_complete(task2.task_id)

      expect(@project1.completed_tasks.length).to eq(2)
    end

    it "returns a list of completed tasks that are sorted by creation date" do
      task = TM::Task.new("Create gradebook", @project1.id, 1)
      allow(Date).to receive(:today).and_return(Date.parse("14 Feb 2014"))
      task2 = TM::Task.new("Add students", @project1.id, 2)
      allow(Date).to receive(:today).and_return(Date.parse("14 March 2014"))
      task3 = TM::Task.new("Add tests", @project1.id, 3)
      allow(Date).to receive(:today).and_return(Date.parse("14 March 2012"))
      task4 = TM::Task.new("Add tests", @project1.id, 4)

      @project1.add_task(task)
      @project1.add_task(task2)
      @project1.add_task(task3)

      @project1.mark_complete(task.task_id)
      @project1.mark_complete(task2.task_id)
      @project1.mark_complete(task3.task_id)

      expect(@project1.completed_tasks).to eq([task2, task3, task])
    end
  end

  describe 'incomplete_tasks' do

    before(:each) do
      @task = TM::Task.new("Create gradebook", @project1.id, 1)
      @task2 = TM::Task.new("Add students", @project1.id, 4)
      @task3 = TM::Task.new("Add tests", @project1.id, 2)
    end
    it "returns an array of all incomplete tasks" do
      @project1.add_task(@task)
      @project1.add_task(@task2)
      @project1.add_task(@task3)

      @project1.mark_complete(@task.task_id)

      expect(@project1.incomplete_tasks.length).to eq(2)
    end

    it "returns an array sorted by priority date" do
      @project1.add_task(@task)
      @project1.add_task(@task2)
      @project1.add_task(@task3)

      @project1.mark_complete(@task.task_id)

      expect(@project1.incomplete_tasks).to eq([@task3, @task2])
    end
  end
end
