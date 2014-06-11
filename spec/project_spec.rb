require 'spec_helper'

describe 'Project' do

  before (:each) do
    TM::Project.class_variable_set(:@@counter, 0)
    TM::Task.class_variable_set(:@@counter, 0)
    TM::Task.class_variable_set(:@@tasks_list, [])

    @project_1 = TM::Project.new("Project 1")
    @project_2 = TM::Project.new("Project 2")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "must have a name" do
    expect(@project_1.name).to eq("Project 1")
  end

  it "has a project id" do
    expect(@project_1.project_id).to eq(0)
  end

  xit "can retrieve a list of incomplete tasks sorted by priority, then the age (older first)" do
    task_1 = TM::Task.new(0, "Find clients", 8)
    task_2 = TM::Task.new(0, "Sell books", 6)
    task_3 = TM::Task.new(0, "Sell books", 8)
    expect(@project_1.retrieve_incomplete_tasks.size).to eq(3)
    expect(@project_1.retrieve_incomplete_tasks).to eq([task_2, task_1, task_3])
  end

  it "can retrieve a list of completed tasks sorted by creation time" do
    task_1 = TM::Task.new(0, "Find clients", 8)
    task_2 = TM::Task.new(0, "Sell books", 6)
    task_3 = TM::Task.new(0, "Sell books", 8)
    TM::Task.mark_complete(0)
    TM::Task.mark_complete(1)
    expect(@project_1.retrieve_completed_tasks.size).to eq(2)
    expect(@project_1.retrieve_completed_tasks).to eq([task_1, task_2])
  end

end
