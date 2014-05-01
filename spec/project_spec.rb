require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  before (:each) do
    TM::Project.reset_class_variables
    TM::Task.reset_class_variables
    @project = TM::Project.new("project")
    @project1 = TM::Project.new("project 1")
    @task = TM::Task.new(@project.pid, "description1", 3, "2014-05-08")
    @task1 = TM::Task.new(@project.pid, "description1", 10, "2014-05-08")
    @task2 = TM::Task.new(@project.pid, "description1", 5, "2014-05-08")
  end

  it "initializes with a unique project id and name" do
    expect(@project.pid).to eq 1
    expect(@project.name).to eq "project"
    expect(@project1.pid).to eq 2
  end

  it "adds new tasks to a Project array" do
    expect(@project.tasks.length).to eq 3
  end

  it "retrieves completed tasks and sorts them by creation date" do
    TM::Task.complete_task(@task.task_id)
    TM::Task.complete_task(@task1.task_id)
    TM::Task.complete_task(@task2.task_id)

    expect(@project.completed_tasks.length).to eq 3
    expect(@project.completed_tasks.first.task_id).to eq 1
    expect(@project.completed_tasks.last.task_id).to eq 3
  end

  it "retrieves incomplete tasks and sorts them by priority" do
    @task3 = TM::Task.new(@project.pid, "description1", 3, "2014-05-08")

    expect(@project.incomplete_tasks.first.task_id).to eq 2
    expect(@project.incomplete_tasks.last.task_id).to eq 4
  end
end
