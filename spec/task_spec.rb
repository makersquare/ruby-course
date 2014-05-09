require 'spec_helper'


describe 'Task' do

  before(:each) do
    TM::Project.reset_class_variables
    @project = TM::Project.new("project 1")
    @task_1 = TM::Task.new(@project.id, "task 1", 3)
    @task_2 = TM::Task.new(@project.id, "task 2", 2)
  end


  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "initializes with a id" do
    expect(@task_1.id).to_not eq(1)
  end

  it "initializes with a description" do
    expect(@task_1.description).to eq("task 1")
  end

  describe '.mark_complete' do
  it "shows if a task is complete, by id" do
    TM::Task.mark_complete(@task_1.id)
    expect(@task_1.complete).to eq true
  end
end


end
