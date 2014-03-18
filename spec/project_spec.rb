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
end
