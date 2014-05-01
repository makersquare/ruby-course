require 'spec_helper'
require 'pry-debugger'

describe 'Task' do

  before(:each) do
    TM::Task.reset_class_variables
    @p1 = TM::Project.new("Project 1")
    @t1 = TM::Task.new(1, 'Task 1', 1)
    @t2 = TM::Task.new(1, 'Task 2', 2)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do
    it "A new task can be created with a project id, description, and priority number." do
      expect(@t1.tid).to eq(1)
      expect(@t1.description).to eq("Task 1")
      expect(@t1.pnum).to eq(1)
    end
  end

  describe '#mark_complete' do
    it "A new task can be complete, specified by id" do
      expect(@t1.complete).to eq(false)
      expect(TM::Task.mark_complete(1)).to_not raise_error
      expect(@t1.complete).to eq(true)
    end
  end

  describe '#completed_tasks' do
    it "a project can retrieve all completed tasks" do
      TM::Task.mark_complete(1)
      expect(TM::Task.completed_tasks(1)).to eq([@t1])
    end

    it "the completed tasks are listed by date" do
      Time.stub(:now).and_return(Time.parse('April 14 2014'))
      t3 = TM::Task.new(1, "Task 3", 1)
      TM::Task.mark_complete(1)
      TM::Task.mark_complete(2)
      TM::Task.mark_complete(3)
      expect(TM::Task.completed_tasks(1)).to eq([t3, @t2, @t1])
    end
  end

  describe '#incomplete_tasks' do
    it "a project can retrieve all incomplete tasks sorted by priority number, if priority number is the same, sort by date" do
      Time.stub(:now).and_return(Time.parse('April 14 2014'))
      t3 = TM::Task.new(1, "Task 3", 1)
      expect(TM::Task.incomplete_tasks(1)).to eq([t3, @t1, @t2])
    end
  end
end
