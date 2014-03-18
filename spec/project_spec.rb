require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end
  it "should be initialized with a name" do
    TM::Project.id_counter = 1
    blue = TM::Project.new("name")
    expect(blue.name).to eq("name")
    expect(blue.id).to eq(1)
  end
  it "should be initialized with a unique id" do
     TM::Project.id_counter = 1
    project_one = TM::Project.new('one')
     expect(project_one.id).to eq(1)
  end
  it "creates new task from a project" do
  project_one = TM::Project.new('one')
  project_one.create_new_task("green", 5)
  expect(project_one.tasks.count).to eq(1)
  project_one.create_new_task("red", 4)
  expect(project_one.tasks.count).to eq(2)
  end
  it "a task can be completed by calling upon its task id" do
  TM::Task.id_counter = 1
  project_one = TM::Project.new('one')
  red = project_one.create_new_task("green", 5)
  expect(red.status).to eq("incomplete")
  project_one.complete_task(1)
  expect(red.status).to eq("complete")
  end
  it "returns an array of completed tasks sorted by creation date" do
    TM::Task.id_counter = 1
    project_one = TM::Project.new('one')
    Time.stub(:now).and_return(Time.parse("4pm"))
    red = project_one.create_new_task("red", 5)
    Time.stub(:now).and_return(Time.parse("3pm"))
    blue = project_one.create_new_task("blue", 4)
    Time.stub(:now).and_return(Time.parse("5pm"))
    green = project_one.create_new_task("green", 3)
    project_one.complete_task(1)
    project_one.complete_task(2)
    project_one.complete_task(3)
    expect(project_one.completed_tasks).to eq([blue, red, green])
  end
  it "returns an array of incomplete tasks sorted by priority" do
    TM::Task.id_counter = 1
    project_one = TM::Project.new('one')
    Time.stub(:now).and_return(Time.parse("3pm"))
    red = project_one.create_new_task("red", 5)
    Time.stub(:now).and_return(Time.parse("4pm"))
    blue = project_one.create_new_task("blue", 4)
    Time.stub(:now).and_return(Time.parse("5pm"))
    green = project_one.create_new_task("green", 3)
    expect(project_one.incomplete_tasks).to eq([red, blue, green])
  end

end








