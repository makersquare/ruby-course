require 'spec_helper'

describe 'Project' do
  before do
    @project = TM::Project.new("project")
    @project1 = TM::Project.new("project 1")

    # Use this method to reset the pid class variable instead of manually setting to 0 here
    TM::Project.reset_class_variables
  end

  it "initializes with a unique project id and name" do
    expect(@project.pid).to eq 1
    expect(@project.name).to eq "project"
    expect(@project1.pid).to eq 2
    expect(@project1.name).to eq "project 1"
  end
end
