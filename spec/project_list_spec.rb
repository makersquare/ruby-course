require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'
require './lib/task-manager/project_list.rb'

describe "ProjectList" do
  before do
    @pl = TM::ProjectList.new
  end

  it "can create a new project with add_project" do
    result = @pl.add_project("New Project 1")
    expect(result.first.class).to eq(TM::Project)
  end

  it "can add a new task to a project" do
    @pl.add_project("New Project 2")
    @pl.add_task(2, "Chemistry HW", 3)
    result = @pl.projects.last.tasks.last.description
    expect(result).to eq("Chemistry HW")
  end

end
