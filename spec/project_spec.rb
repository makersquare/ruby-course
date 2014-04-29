require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "allows project to be created with name optional but autmatically given unique id" do
    project = TM::Project.new("hello")
    expect(project.id).to eq(1)
    expect(project.name).to eq("hello")
  end

  it "allows a task to be marked complete by id" do
    project = TM::Project.new("hello")
    project.create_task(123,"hello",1)
    expect(project.mark_complete(123)).to eq("complete")

  end

  it "A project can retrieve a list of all complete tasks, sorted by creation date " do
    project = TM::Project.new("hello")
    project.create_task(123,"hello",1)
    expect(project.mark_complete(123)).to eq("complete")
    expect(project.completed_tasks()[0].project_id).to eq(123)
  end

  it "A project can retrieve a list of all incomplete tasks, sorted by priority then by creation date " do
    project = TM::Project.new("hello")
    project.create_task(123,"hello",1)
    #expect(project.mark_complete(123)).to eq("complete")
    project.mark_complete(123)
    project.create_task(122,"yessir",1)
    project.create_task(145,"jimbo", 10)
    project.create_task(111,"hey",1)
    expect(project.tasks.length).to eq(4)
    expect(project.incomplete_tasks().length).to eq(3)
    expect(project.incomplete_tasks()[0].project_id).to eq(122)
    expect(project.incomplete_tasks()[1].project_id).to eq(111)
    expect(project.incomplete_tasks()[2].project_id).to eq(145)
  end

end
