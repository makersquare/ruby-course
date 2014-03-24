require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "can create a new project with a name" do
    expect(TM::Project).to receive(:gen_id).and_return(0)
    pl = TM::DB.new
    pl.addproject("Name")
    expect(pl.projects[0].name).to eq("Name")
    expect(pl.projects[0].project_id).to eq(0)
  end

  it "is assigned a unique id" do
    expect(TM::Project).to receive(:gen_id).and_return(0)
    pl = TM::DB.new
    pl.addproject("Name")
    expect(pl.projects[0].name).to eq("Name")
    expect(pl.projects[0].project_id).to eq(0)
  end

  it "can mark a project complete, specified by id" do
    project = TM::Project.new("Name")
    # task = TM::Task.new(10,"Description",1)
    expect(TM::Task).to receive(:gen_id).and_return(10)
    project.addtask("Description",1)
    project.markcomplete(10)
    expect(project.tasks[10].complete).to eq(true)
  end

  it "can retrieve a list of all complete tasks, sorted by creation date" do
    project = TM::Project.new("Project")
    TM::Task.class_variable_set :@@task_count, 0
    project.addtask("asdf",1)
    project.addtask("werwer",2)
    project.addtask("dfgdf",4)
    project.addtask("tyrrty",3)
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
    TM::Task.class_variable_set :@@task_count, 0
    project.addtask("asdf",1)
    project.addtask("werwer",2)
    project.addtask("dfgdf",4)
    project.addtask("tyrrty",3)
    project.markcomplete(1)
    expect(project.incompletelist[0].description).to eq("werwer")
    expect(project.incompletelist[1].description).to eq("tyrrty")
    expect(project.incompletelist[2].description).to eq("dfgdf")
  end

  it "prioritizes older tasks in incompletelist" do
    project = TM::Project.new("Project")
    project.addtask("Proj 1",2)
    project.addtask("Proj 2",1)
    project.addtask("Proj 3",2)
    project.addtask("Proj 4",2)
    project.addtask("Proj 5",3)

    expect(project.incompletelist.size).to eq(5)

    expect(project.incompletelist[0].description).to eq("Proj 2")
    expect(project.incompletelist[1].description).to eq("Proj 1")
    expect(project.incompletelist[2].description).to eq("Proj 3")
    expect(project.incompletelist[3].description).to eq("Proj 4")
    expect(project.incompletelist[4].description).to eq("Proj 5")
  end
end
