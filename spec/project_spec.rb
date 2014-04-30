require 'spec_helper'

describe 'Project' do

  before(:each) do
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
    @p1 = TM::Project.new("Project 1")
  	@p2 = TM::Project.new("Project 2")
  	@t1 = TM::Task.new(1, "Task 1", 1)
  	@t2 = TM::Task.new(1, "Task 2", 1)
  	@p1.add_task(@t1)
  	@p1.add_task(@t2)
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "allows a new project to be created with a name" do
      expect(@p1).to be_a(TM::Project)
      expect(@p1.name).to eq("Project 1")
  end

  it "initializes with a unique id" do
  	expect(@p1.pid).to eq(1)
  	expect(@p2.pid).to eq(2)
  end

  it "can add a new task to a project" do
  	expect(@p1.list_tasks).to eq([@t1, @t2])
  end

  it "A new task can be complete, specified by id" do
  	expect(@t1.complete).to eq(false)
  	expect(@p1.mark_complete(1, 1)).to_not raise_error
  	expect(@t1.complete).to eq(true)
  end

  it "a project can retrieve all completed tasks" do
  	@p1.mark_complete(1,1)
  	expect(@p1.completed_tasks(1)).to eq([@t1])
  end

  it "the completed tasks are listed by date" do
  	Time.stub(:now).and_return(Time.parse('April 14 2014'))
  	@t3 = TM::Task.new(1, "Task 3", 1)
  	@p1.add_task(@t3)
  	@p1.mark_complete(1, 1)
  	@p1.mark_complete(1, 2)
  	@p1.mark_complete(1, 3)
  	expect(@p1.completed_tasks(1)).to eq([@t3, @t1, @t2])
  end
end
