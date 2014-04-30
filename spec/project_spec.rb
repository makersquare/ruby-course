require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  before (:each) do
    @project = TM::Project.new("project")
    @project1 = TM::Project.new("project 1")
    @task = TM::Task.new(@project, "description1", 3)
    @task1 = TM::Task.new(@project, "description2", 5)
    @task2 = TM::Task.new(@project, "description3", 10)


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
    @project.add_task(@task)
    @project.complete_task(1)

    expect(@task.status).to eq 1
  end

  it "retrieves completed tasks and sorts them by completion date" do
    # Add tasks out of order so we can check for sorting by creation date
    @project.add_task(@task1)
    @project.add_task(@task)
    @project.add_task(@task2)

    @project.complete_task(1)
    @project.complete_task(2)
    @project.complete_task(3)

    expect(@project.completed_tasks.length).to eq 3
    expect(@project.completed_tasks.first).to eq @task
    expect(@project.completed_tasks.last).to eq @task2
  end
end
