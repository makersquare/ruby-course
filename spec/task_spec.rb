require 'spec_helper'

describe 'Task' do
  before do
    @project = TM::Project.new("project")
    @task = TM::Task.new(@project.pid, "description1", 3)
    @task1 = TM::Task.new(@project.pid, "description", 5)
  end

  it "inializes with a project id, description and priority number" do
    expect(@task.project_id).to eq (@project.pid)
    expect(@task.description).to eq ("description1")
    expect(@task.priority).to eq 3
  end

  it "marks tasks as complete" do
    # binding.pry
    TM::Task.complete_task(@task.task_id)

    expect(@task.status).to eq 1
  end

end
