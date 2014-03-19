require 'spec_helper'
require './lib/task-manager/project.rb'
require './lib/task-manager/task.rb'
require './lib/task-manager/project_list.rb'

describe "ProjectList" do
  before do
    @pl = TM::ProjectList.new
  end

  it "can create a new project with add_project" do
    result = @pl.create_project("New Project 1")
    expect(result.first.class).to eq(TM::Project)
  end

  # it "can list projects" do
  #   @pl.create_project("New Project 2")
  #   expect(@projects.last).to eq(newproject)
  # end


end
