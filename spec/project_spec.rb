require 'spec_helper'

describe 'Project' do

  before (:each) do
    project_1 = TM::Project.new("Project 1")
    project_2 = TM::Project.new("Project 2")
    task_1 = TM::Task.new(0, "Find clients", 9)
    task_2 = TM::Task.new(0, "Sell books", 6)
    project_1.complete(0)
  end

  xit "exists" do
    expect(TM::Project).to be_a(Class)
  end

  xit "must have a name" do
    expect(project_1.name).to eq("Project 1")
  end

  xit "has a project id" do
    expect(project_1.project_id).to eq(0)
  end

  xit "can retrieve a list of incomplete tasks" do
    expect(project_1.retrieve_completed_tasks).to eq(project_2)
  end

  xit "can change a task to completed by task id" do
    expect(project_1.complete(0)).to eq("complete")
  end

  xit "can retrieve a list of completed tasks" do
    expect(project_1.complete(0)).to eq("complete")
# Needs to be changed

  end

end
