require 'spec_helper'
require 'pry-debugger'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before(:each) do
    TM::Task.reset_class_variables
    @project1 = TM::Project.new("Grades")
    @task = TM::Task.new("Create gradebook", @project1.id, 1)
  end

  describe 'initialize' do

    it "Creates a task that has a description" do
      expect(@task.description).to eq("Create gradebook")
    end

    it "Creates a task that assigns the project's id to it" do
      expect(@task.project_id).to eq(@project1.id)
    end

    it "Creates a task that has a priority number" do
      expect(@task.priority).to eq(1)
    end

    it "Creates a task that has it's own id number" do
      expect(@task.task_id).to_not raise_error()
    end

    it "Creates a status attribute that is initialized to not complete" do
      expect(@task.status).to eq("Not completed")
    end

    it "is initialized with a creation date" do
      project2 = TM::Project.new("Tests")
      allow(Date).to receive(:today).and_return(Date.parse("14 Feb 2014"))
      task = TM::Task.new("Create gradebook", project2.id, 1)

      expect(task.creation_date.to_s).to eq("2014-02-14")
    end

    it "has a due date attribute with a default value of Date.today" do
      expect(@task.options[:due_date]).to eq(Date.today)
    end

    it "can be initialized with tags" do
      task = TM::Task.new("Create gradebook", @project1.id, 1, {:tags => ["School", "Grading"]})
      expect(task.options[:tags]).to eq(["School", "Grading"])
    end
  end

  describe 'add_tags' do
     it "can have tags added to it" do
      @task.add_tags(["School", "Grading"])
      expect(@task.options[:tags]).to eq(["School", "Grading"])
    end

    it "doesn't override other tags when new tags are added" do
      task = TM::Task.new("Create gradebook", @project1.id, 1, {:tags => ["School", "Grading"]})
      task.add_tags(["Students"])
      expect(task.options[:tags]).to eq(["School", "Grading", "Students"])
    end
  end

  it "has a class variable that tracks all created tasks" do
    expect(TM::Task.tasks.length).to eq(1)
  end

  it "allows a due date to be added to a task" do
    @task.due_date = "1 March 2015"
    expect(@task.options[:due_date].to_s).to eq("2015-03-01")
  end

  it 'finds a task with inputted id' do
    task2 = TM::Task.new("Start Grading", @project1.id, 1)
    expect(TM::Task.find_task(1)).to eq(@task)
  end

  describe 'mark_complete' do
    it "marks a task as completed" do
      TM::Task.mark_complete(1)
      expect(@task.status).to eq("Completed")
    end

    it "changes the date_completed to Date.today" do
      TM::Task.mark_complete(1)
      expect(@task.date_completed).to eq(Date.today.to_s)
    end
  end
end
