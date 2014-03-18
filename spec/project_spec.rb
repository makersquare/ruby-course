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

  it "can mark a project complete, specified by id" do
    project = TM::Project.new("Name")
    # task = TM::Task.new(10,"Description",1)
    project.addtask(10,"Description",1)
    project.markcomplete(10)
    expect(project.tasks[10].complete).to eq(true)
  end

  it "can retrieve a list of all complete tasks, sorted by creation date" do
    project = TM::Project.new("Project")
    project.addtask(1,"asdf",1)
    project.addtask(2,"werwer",2)
    project.addtask(3,"dfgdf",4)
    project.addtask(4,"tyrrty",3)
    project.markcomplete(1)
    project.markcomplete(3)
    project.markcomplete(4)
    expect(project.completedlist[0].description).to eq("asdf")
    expect(project.completedlist[1].description).to eq("dfgdf")
    expect(project.completedlist[2].description).to eq("tyrrty")
    expect(project.completedlist.length).to eq(3)
  end
end
