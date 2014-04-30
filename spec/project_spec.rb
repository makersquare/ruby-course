require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  before (:each) do
    @project = TM::Project.new("project")
    @project1 = TM::Project.new("project 1")
    @project.add_task(@project.pid, "description1", 3)
    @project.add_task(@project.pid, "description2", 10)
    @project.add_task(@project.pid, "description3", 5)
    @project.add_task(@project.pid, "description4", 3)

    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
  end

  it "initializes with a unique project id and name" do
    expect(@project.pid).to eq 1
    expect(@project.name).to eq "project"
    expect(@project1.pid).to eq 2
  end

  it "adds new tasks to a Project array" do
    expect(@project.tasks.length).to eq 4
    expect(@project.tasks)
  end

  it "allows tasks to be marked as complete by task_id" do
    @project.complete_task(1)

    expect(@project.tasks.first.status).to eq 1
  end

  it "retrieves completed tasks and sorts them by creation date" do
    @project.complete_task(1)
    @project.complete_task(2)
    @project.complete_task(3)

    expect(@project.completed_tasks.length).to eq 3
    expect(@project.completed_tasks.first.task_id).to eq 1
    expect(@project.completed_tasks.last.task_id).to eq 3
  end

  it "retrieves incomplete tasks and sorts them by priority" do
    expect(@project.incomplete_tasks.first.task_id).to eq 2
    expect(@project.incomplete_tasks.last.task_id).to eq 4
  end
end
