require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'
require './lib/task-manager/database.rb'

describe "Database" do
  before do
    @pl = TM::Database.new
  end

  it "can create a new project with add_project" do
    result = @pl.add_project("New Project 1")
    expect(result.first.class).to eq(TM::Project)
  end

  it "can add a new task to a project" do
    @pl.add_project("New Project 2")
    task_object = @pl.add_new_task("Chemistry HW", 2, 3)
    result = @pl.projects.last.tasks[1]
    expect(result).to eq(task_object)
  end

end
