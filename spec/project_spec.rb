require 'spec_helper'

describe 'Project' do
  # before(:each) do
  #   TM::Project.reset_class_variables
  # end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  xit "creates an empty array at initalization" do
    new_project = TM::Project.new
    expect(new_project.project_list).to eq({ 1 => []})
  end

  xit "gives new project without name specified default name 'New Project w/ Project ID'" do
    expect(TM::Project.new.name).to eq("New Project - 1")
  end

  xit "take name arugment of new project instance" do
    test_project = TM::Project.new("Cleaning")
    expect(test_project.name).to eq("Cleaning - 1")
  end

  xit "adds a date created at initiation" do
    @created = Time.parse("Feb 24 1981")
    Time.stub(:now).and_return(@created)
  end

  xit "adds project to class instances array" do
    TM::Project.new("Project 1")
    TM::Project.new("Project 2")
    expect(self.project_instances_list).to eq(["Project 1", "Project 2"])
  end
end

  describe 'project class' do
  xit "increments project class - project count when new instance created" do
    TM::Project.new
    expect(TM::Project.project_count).to eq(1)
  end
  end

