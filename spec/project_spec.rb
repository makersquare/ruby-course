require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "creates an empty array at initalization" do
    new_project = TM::Project.new
    expect(new_project.list).to eq([])
  end

  it "gives new project without name specified default name 'New Project w/ Project ID'" do
    expect(TM::Project.new.name).to eq("New Project - 1")
  end

  it "take name arugment of new project instance" do
    test_project = TM::Project.new("Cleaning")
    expect(test_project.name).to eq("Cleaning - 2")
  end

  it "adds a date created at initiation" do
    @created = Time.parse("Feb 24 1981")
    Time.stub(:now).and_return(@created)
  end







end
