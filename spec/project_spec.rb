require 'spec_helper'
require 'pry-debugger'

describe 'Project' do

  before(:each) do
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
    @project1 = TM::Project.new("Grades")
    @project2 = TM::Project.new("Tests")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe 'class methods' do

    # describe 'projects' do

    #   it "Stores a list of all created projects" do
    #     expect(TM::Project.projects.length).to eq(2)
    #   end

    #   it "returns a list of all created projects" do
    #     expect(TM::Project.projects).to eq([@project1, @project2])
    #   end
    # end

    describe 'list_all' do
      it "lists all projects" do
        task = TM::Task.new("Create gradebook", @project1.id, 1)
        task2 = TM::Task.new("Add students", @project1.id, 2)
        task3 = TM::Task.new("Create gradebook", @project2.id, 1)
        task4 = TM::Task.new("Add students", @project2.id, 2)

        @project1.add_task(task)
        @project1.add_task(task2)
        @project2.add_task(task3)
        @project2.add_task(task4)

        task.due_date = "1 Feb 2014"
        task2.due_date = "1 June 2012"
        task3.due_date = "3 Feb 2015"
        task4.due_date = "1 May 2020"

        TM::Task.mark_complete(1)
        STDOUT.should_receive(:puts).with("Name: Grades - ID: 1")
        STDOUT.should_receive(:puts).with("Percentage Finished - 50.0%")
        STDOUT.should_receive(:puts).with("Percentage Tasks Overdue - 50.0%")
        STDOUT.should_receive(:puts).with("Name: Tests - ID: 2")
        STDOUT.should_receive(:puts).with("Percentage Finished - 0%")
        STDOUT.should_receive(:puts).with("Percentage Tasks Overdue - 0%")
        TM::Project.list_all

      end
    end

    # describe 'find_project' do
    #   it "returns the project that matches the given project id" do
    #     expect(TM::Project.find_project(2)).to eq(@project2)
    #   end

    #   it "returns nil if given id has no matching project" do
    #     expect(TM::Project.find_project(5)).to eq(nil)
    #   end
    # end
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

  describe 'completed_tasks' do
    it "returns an array/list of all completed tasks in the project" do
      task = TM::Task.new("Create gradebook", @project1.id, 1)
      task2 = TM::Task.new("Add students", @project1.id, 2)
      task3 = TM::Task.new("Add tests", @project1.id, 3)

      @project1.add_task(task)
      @project1.add_task(task2)
      @project1.add_task(task3)

      TM::Task.mark_complete(task.task_id)
      TM::Task.mark_complete(task2.task_id)

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

      TM::Task.mark_complete(task.task_id)
      TM::Task.mark_complete(task2.task_id)
      TM::Task.mark_complete(task3.task_id)

      expect(@project1.completed_tasks).to eq([task2, task3, task])
    end
  end

  describe 'incomplete_tasks' do

    it "returns an array of all incomplete tasks" do
      task = TM::Task.new("Create gradebook", @project1.id, 1)
      task2 = TM::Task.new("Add students", @project1.id, 4)
      task3 = TM::Task.new("Add tests", @project1.id, 2)

      @project1.add_task(task)
      @project1.add_task(task2)
      @project1.add_task(task3)

      TM::Task.mark_complete(task.task_id)

      expect(@project1.incomplete_tasks.length).to eq(2)
    end

    it "returns an array sorted by priority" do
      task = TM::Task.new("Create gradebook", @project1.id, 1)
      task2 = TM::Task.new("Add students", @project1.id, 4)
      task3 = TM::Task.new("Add tests", @project1.id, 2)

      @project1.add_task(task)
      @project1.add_task(task2)
      @project1.add_task(task3)

      TM::Task.mark_complete(task.task_id)

      expect(@project1.incomplete_tasks).to eq([task3, task2])
    end

    it "returns an array sorted by overdue dates" do
      task = TM::Task.new("Create gradebook", @project1.id, 4)
      task2 = TM::Task.new("Add students", @project1.id, 3)
      task3 = TM::Task.new("Add tests", @project1.id, 2)

      @project1.add_task(task)
      @project1.add_task(task2)
      @project1.add_task(task3)

      task.due_date = "1 Feb 2014"
      task2.due_date = "1 June 2014"
      task3.due_date = "3 Feb 2014"

      expect(@project1.incomplete_tasks).to eq([task, task3, task2])
    end

    it "returns an array sorted by priority and creation date" do
      task = TM::Task.new("Create gradebook", @project1.id, 1)
      allow(Date).to receive(:today).and_return(Date.parse("14 Feb 2014"))
      task2 = TM::Task.new("Add students", @project1.id, 1)
      allow(Date).to receive(:today).and_return(Date.parse("14 March 2014"))
      task3 = TM::Task.new("Add tests", @project1.id, 2)
      allow(Date).to receive(:today).and_return(Date.parse("14 March 2012"))
      task4 = TM::Task.new("Add hw", @project1.id, 2)

      @project1.add_task(task)
      @project1.add_task(task2)
      @project1.add_task(task3)
      @project1.add_task(task4)

      task2.due_date = "1 May 2010"
      task3.due_date = "1 May 2014"
      task4.due_date = "1 May 2013"

      TM::Task.mark_complete(task.task_id)

      expect(@project1.incomplete_tasks).to eq([task2, task4, task3])
    end
  end

  describe 'Project task completion' do
    before(:each) do
      @task = TM::Task.new("Create gradebook", @project1.id, 1)
      @task2 = TM::Task.new("Add students", @project1.id, 2)
      @task3 = TM::Task.new("Add tests", @project1.id, 3)

      @project1.add_task(@task)
      @project1.add_task(@task2)
      @project1.add_task(@task3)
    end

    describe 'percentage_complete' do
      it "returns 0 if no tasks have been completed" do
        expect(@project1.percentage_complete).to eq(0)
      end

      it "returns a percentage of the tasks that are complete in a project" do
        TM::Task.mark_complete(2)
        expect(@project1.percentage_complete).to eq(33.0)
      end
    end

    describe 'overdue_tasks' do
      it "returns 0 if no tasks are overdue" do
        expect(@project1.overdue_tasks).to eq(0)
      end

      it "returns a percentage of the tasks that are overdue in a project" do
        @task.due_date = "1 Jan 2014"
        @task2.due_date = "1 May 2016"
        @task3.due_date = "3 Feb 2014"

        expect(@project1.overdue_tasks).to eq(67.0)
      end
    end
  end
end
