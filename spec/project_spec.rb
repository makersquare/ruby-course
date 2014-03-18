require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "can create a new project with a name" do
    project = TM::Project.new("Name")
    expect(project.name).to eq("Name")
  end

  it "is assigned a unique id" do
    project = TM::Project.new("Name")
    expect(project.id).to eq(2)
    project = TM::Project.new("Name")
    expect(project.id).to eq(3)
  end


end
