require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  before(:each) do
    @p1 = TM::Project.new("My First Project")
    @p2 = TM::Project.new("My Second Project")
    @p1.new_task("complete task manager", 1)
    @p1.new_task("sleep", 3)
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
  end
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe ".initialize" do
    it "creates a new project with name" do
      expect(@p1.name).to eq("My First Project")
    end

    it "automatically assigns a project ID to new project" do
      expect(@p1.id).to eq(1)
      expect(@p2.id).to eq(2)
    end
  end

  describe 'new_task' do

    it "creates a new task" do
      expect(@p1.tasks.length).to eq(2)
      expect(@p1.tasks.first).to be_a(Object)
      expect(@p1.tasks.first.pid).to eq(@p1.id)
      expect(@p1.tasks.first.tid).to eq(1)
      expect(@p1.tasks.first.description).to eq("complete task manager")
      expect(@p1.tasks.first.priority).to eq(1)
    end
  end

  describe 'set_priority' do
    it "changes priority level for task" do
      @p1.set_priority(1, 2)

      expect(@p1.tasks.first.priority).to eq(2)
    end
  end

  describe 'completed_tasks' do
    before(:each) do
      @p1.tasks.each {|task| task.set_complete }
      @p1.completed_tasks
    end
    it "creates an array of completed tasks" do
      expect(@p1.complete_tasks.length).to eq(2)
    end
    it "orders array by earliest creation date first" do
    # binding.pry
      @p1.complete_tasks.first.time.should be < @p1.complete_tasks.last.time
    end
  end

  describe 'todo' do
    before(:each) do
      @p1.todo
      @p1.set_priority(1, 3)
      @p1.set_priority(2, 1)
    end
    it "creates an array of incomplete tasks" do
      expect(@p1.incomplete_tasks.length).to eq(2)
    end

    it "orders array by highest priority" do
      @p1.incomplete_tasks.first.priority.should be < @p1.incomplete_tasks.last.priority
    end

    it "orders array by date if priority levels are equal" do
      @p1.new_task("eat", 3)
      @p1.new_task("work harder", 1)
      @p1.todo

      expect(@p1.incomplete_tasks.length).to eq(4)
      @p1.incomplete_tasks.first.time.should be < @p1.incomplete_tasks[1].time
      @p1.incomplete_tasks[2].time.should be < @p1.incomplete_tasks.last.time
    end
  end
end
