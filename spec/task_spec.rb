require 'spec_helper'
require 'time'
require 'pry-debugger'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before(:each) do
    TM::Task.reset_class_variable
    Time.stub(:now).and_return(Time.parse("1994/4/29"))
    @time = Time.now
    @task1 = TM::Task.new("Build a garden", 1, 1)
    Time.stub(:now).and_return(Time.parse("1992/4/29"))
    @time2 = Time.now
    @task2 = TM::Task.new("Fix the cracks on the skirting", 2, 1)
    Time.stub(:now).and_return(Time.parse("1997/4/28"))
    @time3 = Time.now
    @task3 = TM::Task.new("Clean carport", 3, 1)
  end

  it "initializes with a project name" do
    expect(@task1.new_task).to eq("Build a garden")
    expect(@task2.new_task).to eq("Fix the cracks on the skirting")
    expect(@task3.new_task).to eq("Clean carport")
  end

  it "gives each project a time stamp" do

    expect(@task3.time).to eq(@time3)
    expect(@task2.time).to eq(@time2)
    expect(@task1.time).to eq(@time)

  end

  it "assigns a priority" do
    expect(@task1.priority).to eq(1)
    expect(@task2.priority).to eq(2)
    expect(@task3.priority).to eq(3)
  end

  it "ties task to project with pid" do
    expect(@task1.pid).to eq(1)
    expect(@task2.pid).to eq(1)
    expect(@task3.pid).to eq(1)
  end

  it "assigns a tid to each task" do
    expect(@task1.tid).to eq(1)
    expect(@task2.tid).to eq(2)
    expect(@task3.tid).to eq(3)
  end

  it "initializes with completion status false" do
    expect(@task1.complete).to eq(false)
    expect(@task2.complete).to eq(false)
    expect(@task3.complete).to eq(false)
  end

  it "pushes tasks on to class variable tasks" do
    expect(TM::Task.tasks).to eq([])



    TM::Task.add_tasks(@task1)
    TM::Task.add_tasks(@task2)
    TM::Task.add_tasks(@task3)
    expect(TM::Task.tasks).to eq([@task1, @task2, @task3])
  end

  it "accepts tid and marks task as complete" do
    TM::Task.add_tasks(@task1)
    TM::Task.add_tasks(@task2)
    TM::Task.add_tasks(@task3)
    # TM::Task.completed_tasks(@task1)



    expect(TM::Task.tasks).to eq([@task1, @task2, @task3])
    expect(TM::Task.completed).to eq([])
    TM::Task.is_complete(1)
    expect(@task1.complete).to eq(true)
    expect(TM::Task.completed).to eq([@task1])
  end



end
