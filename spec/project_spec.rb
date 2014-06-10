require 'spec_helper'

describe 'Project' do

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  before do
    project_1 = TM::Project.new("Project 1")
    project_2 = TM::Project.new("Project 2")
    task_1 = TM::Task.new(0, "Find clients", 9)
    task_2 = TM::Task.new(0, "Sell books", 6)
    project_1.complete(0)
  end

  it "must have a name" do
    expect(project_1.name).to eq("Project 1")
  end

  it "has a project id" do
    expect(project_1.project_id).to eq("Project 1")
  end

  it "can retrieve a list of incomplete tasks" do
    expect(project_1.retrieve_completed_tasks).to eq(project_2)
  end

  it "can change a task to completed by task id" do
    expect(project_1.complete(0)).to eq("completed")
  end

  it "can retrieve a list of completed tasks" do
    expect(project_1.complete(0)).to eq("completed")
  end

end
