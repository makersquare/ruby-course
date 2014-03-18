require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'

describe 'Project' do
  before do
    @new_project = TM::Project.new("New Project Name")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes and has a project name" do
    result = @new_project.name
    expect(result).to eq("New Project Name")
  end

  it "initializes with an id" do
    result = @new_project.id
    expect(result).to eq(3)
  end

  it "can add tasks to a project" do
    test_task = TM::Task.new(1, "new task", 5)
    @new_project.add_task(test_task)
    expect(@new_project.tasks.last).to eq(test_task)
  end

end
