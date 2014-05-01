require 'spec_helper'
require 'pry-debugger'

describe 'Task' do
  before do
    @project = TM::Project.new("project")
    @task = TM::Task.new(@project.pid, "description1", 3, "2014-05-08")

  end

  it "inializes with a project id, description, priority number and due_date" do
    expect(@task.project_id).to eq (@project.pid)
    expect(@task.description).to eq ("description1")
    expect(@task.priority).to eq 3
    expect(@task.due_date).to eq (Date.parse("2014-05-08"))
  end

  it "marks tasks as complete" do
    expect(@task.status).to eq 0
    TM::Task.complete_task(@task.task_id)

    expect(@task.status).to eq 1
  end

  it "has a due date" do

  end
end
