require 'spec_helper'

describe 'Task' do

  before (:each) do
    TM::Task.class_variable_set(:@@counter, 0)
    TM::Task.class_variable_set(:@@tasks_list, [])

    @project_1 = TM::Project.new("Project 1")
    @project_2 = TM::Project.new("Project 2")
    @task_1 = TM::Task.new(0, "Find clients", 9)
    @task_2 = TM::Task.new(0, "Sell books", 6)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "has a task id" do
    expect(@task_2.task_id).to eq(1)
  end

  it "has a project id" do
    expect(@task_1.project_id).to eq(0)
  end

  xit "has a time stamp" do
    expect(@task_1.creation_time).to eq(Time.now)
  end

  it "has a default completion status of :incomplete" do
    expect(@task_1.status).to eq(:incomplete)
  end

  it "has task objects stored in a tasks array" do
    expect(TM::Task.tasks_list.size).to eq(2)
  end

  it "can be marked as complete specified by task id" do
    TM::Task.mark_complete(0)
    expect(@task_1.status).to eq(:complete)    
  end

end