require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "must have a name" do
    project = TM::Project.new("Project 1")
    expect(project.name).to eq("Project 1")
  end

  it "has a project id" do
    project = TM::Project.new("Project 1")
    expect(project.id).to eq("Project 1")
  end

  xit "can retrieve a list of completed tasks"
  end

  xit "can retrieve a list of incomplete tasks"
  end
end
