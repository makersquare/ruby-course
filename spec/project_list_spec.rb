require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'
require './lib/task-manager/project_list.rb'


describe "Project_list" do
  before do
    @pl = TM::Project_list.new
  end

  it "can create a new project with #add_project" do
    result = @pl.add_project("New Project")
    expect(result.first.class).to eq(TM::Project)
  end

  it "can add a new task to a project" do
    @pl.add_project("Project")
    @pl.add_task(2, 3, "add task")
    result = @pl.projects.first.tasks.first.description
    expect(result).to eq("add task")
  end

end
