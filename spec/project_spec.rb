require 'spec_helper'


describe 'Project' do
  before(:each) do
    TM::Project.reset_class_variables
  end

  # binding.pry

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "adds a date created at initiation" do
    @created = Time.parse("Feb 24 1981")
    Time.stub(:now).and_return(@created)
  end

  it "creates an empty array at initalization" do
    new_project = TM::Project.new
    expect(new_project.task_list).to eq([])
  end

  it "gives new project without name specified default name 'New Project'" do
    expect(TM::Project.new.name).to eq("New Project - 1")
  end



  it "it gives the project an a unique id number" do
    new_project_1 = TM::Project.new
    new_project_2 = TM::Project.new
    # expect(new_project_1.id).should_not == new_project_2.id
    expect(new_project_1.id).to eq(1)
    expect(new_project_2.id).to eq(2)
  end

  it "take name arugment of new project instance" do
    test_project = TM::Project.new("Cleaning")
    expect(test_project.name).to eq("Cleaning - 1")
  end

  it "adds project to class instances array" do
    TM::Project.new("Project")
    TM::Project.new("Project")
    expect(TM::Project.project_list).to eq(["Project - 1", "Project - 2"])
  end


end


