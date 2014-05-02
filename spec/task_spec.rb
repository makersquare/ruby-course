require 'spec_helper'
require 'pry'             #used to allow Pry debugger

describe 'Task' do    #describes what the Task class should do

  # 'TM::Project.reset_class_variables' is an example of using a Class method
  # '@project_1' is an example of using an instance method
  # the @ also indicates that it is a
  before(:each) do
    TM::Project.reset_class_variables         #class method
    @project_1 = TM::Project.new("proj1")     #Project intstance method
    @task_1 = TM::Task.new(1, "First Task", 1)                  #Task intstance method
  end

  #it-statements are used to test different functionalities and methods
  #it 'exists' is a simple way of testing that TM::Project is a class
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "a new task is created with a project_id" do
    # @task_1 = TM::Task.new(1, "First Task", 1)
    expect(@task_1.project_id).to eq(1)
  end

  it "a new task can be created with a description" do
    # @task_1 = TM::Task.new(1, "First Task", 1)
    expect(@task_1.task_description).to eq("First Task")
  end

  it "a new task can be created with a priority number" do
    # @task_1 = TM::Task.new(1, "First Task", 1)
    expect(@task_1.task_priority_number).to eq(1)
  end

  it "a task can be marked complete specified by id" do
    expect(TM::Task.completed(1)).to eq(true)
  end
end
