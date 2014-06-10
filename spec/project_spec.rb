require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "must have a name" do
    project = TM::Project.new("Project 1")
    expect(project.name).to eq("Project 1")
  end

  it "has a project id" do
    project = TM::Project.new("Project 1")
    expect(project.id).to eq("Project 1")
  end

  it "can retrieve a list of incomplete tasks" do
  end


  it "can change a task to completed by task id" do
    project_1 = TM::Project.new("Project 1")
    task_1 = TM::Task.new(1, "Find clients", 5)
    expect(project_1.complete(1)).to eq("completed")
  end

  it "can retrieve a list of completed tasks" do
   project = TM::Project.new("Project 1")
   task_1 = TM::Task.new(0, "Find clients", 5)
   task_2 = TM::Task.new(0, "Sell books", 5)
  end
end



# project can retrieve

#   list of complete tasks
#     sort by creation date

#   list of incomplete tests
#     sort by priority number
