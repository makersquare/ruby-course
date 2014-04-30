require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  before do
    @project = TM::Project.new("project")
    @project1 = TM::Project.new("project 1")
    @task = TM::Task.new(@project, "description1", 3)


    # Use this method to reset the pid class variable instead of manually setting to 0 here
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
  end

  it "initializes with a unique project id and name" do
    expect(@project.pid).to eq 1
    expect(@project.name).to eq "project"
    expect(@project1.pid).to eq 2
    expect(@project1.name).to eq "project 1"
  end

  it "adds adds new tasks to a Project array" do
    @project.add_task(@task)
    expect(@project.tasks.length).to eq 1
    expect(@project.tasks)
  end

  it "allows tasks to be marked as complete by task_id" do
    # binding.pry
    @project.add_task(@task)
    @project.complete_task(1)

    expect(@task.status).to eq 1
  end

end
