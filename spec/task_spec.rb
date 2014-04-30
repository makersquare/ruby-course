require 'spec_helper'


describe 'Task' do

  before(:each) do
    TM::Project.reset_class_variables
    @project_1 = TM::Project.new("p1")
    @task_1 = TM::Task.new(1, "task1", 3)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes with a project id" do
    expect(@project_1.id).to eq(1)
  end

  it "initializes with a description" do
    expect(@task_1.description).to eq("task1")
  end

  it "initializes with a priority number" do
    expect(@task_1.priority_number).to eq(3)
  end
end
