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
    expect(result.class).to eq(Fixnum)
  end



end
