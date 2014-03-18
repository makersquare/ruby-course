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

  it "can retrieve a list of all incomplete tasks, sorted by priority" do
    project = TM::Project.new("Project")
    project.addtask(1,"asdf",1)
    project.addtask(2,"werwer",2)
    project.addtask(3,"dfgdf",4)
    project.addtask(4,"tyrrty",3)
    project.markcomplete(1)
    expect(project.incompletelist[0].description).to eq("werwer")
    expect(project.incompletelist[1].description).to eq("tyrrty")
    expect(project.incompletelist[2].description).to eq("dfgdf")
  end

  it "prioritizes older tasks in incompletelist" do
    project = TM::Project.new("Project")
    project.addtask(1,"Proj 1",2)
    project.addtask(2,"Proj 2",1)
    project.addtask(3,"Proj 3",2)
    project.addtask(4,"Proj 4",2)
    project.addtask(5,"Proj 5",3)

    expect(project.incompletelist[0].description).to eq("Proj 2")
    expect(project.incompletelist[1].description).to eq("Proj 1")
    expect(project.incompletelist[2].description).to eq("Proj 3")
    expect(project.incompletelist[0].description).to eq("Proj 4")
    expect(project.incompletelist[1].description).to eq("Proj 5")
  end
end
