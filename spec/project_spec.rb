require 'spec_helper'

describe 'Project' do

  before(:each) do
    TM::Project.reset_class_variables
    @p1 = TM::Project.new("Project 1")
  	@p2 = TM::Project.new("Project 2")
  end

  xit "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '#initialze' do
    xit "allows a new project to be created with a name" do
        expect(@p1).to be_a(TM::Project)
        expect(@p1.name).to eq("Project 1")
    end

    xit "initializes with a unique id" do
    	expect(@p1.pid).to eq(1)
    	expect(@p2.pid).to eq(2)
    end
  end

  describe '#list_projects' do
    xit "lists all projects" do
    	expect(TM::Project.list_projects).to eq([@p1, @p2])
    end
  end
end
