require 'spec_helper'

describe 'Tracker' do
  it "initializes with an empty array of list of projects and tasks" do
   tracker = TM::ProjectTracker.new
   expect(tracker.projects).to eq([])
   expect(tracker.tasks).to eq([])
  end

  it "gives a specific input when help method is called" do
     tracker = TM::ProjectTracker.new
     expect(tracker.help).to eq("The system is pretty straightforward. Figure it out!")
  end

  it "allows you to add a project and that project is stored in the projects array" do
    tracker = TM::ProjectTracker.new
    expect(tracker.get_projects).to eq("Dude, create a project first!")
    tracker.create_new_project("blue")
    tracker.create_new_project("red")
    expect(tracker.projects.count).to eq(2)
    expect(tracker.projects.first.name).to eq("blue")
  end

it "tests the ability to add tasks to a project" do
  TM::Project.id_counter = 1
  tracker = TM::ProjectTracker.new
  expect(tracker.add_task("5", "yellow", "7")).to eq("Dude, create a project to house your tasks first!")
  tracker.create_new_project("project")
  expect(tracker.projects.count).to eq(1)
  expect(tracker.projects.first.id).to eq(1)
  tracker.add_task("1", "yellow", "7")
  expect(tracker.tasks.count).to eq(1)
end

it "allows you to complete a task" do
  TM::Project.id_counter = 1
  TM::Task.id_counter = 1
  tracker = TM::ProjectTracker.new
  tracker.create_new_project("project")
  blue = tracker.add_task("1", "yellow", "7")
  tracker.complete_task(1)
  expect(blue.status).to eq("complete")
end

it "allows you to create a new employee from tracker" do
  TM::Employee.id_counter = 1
  tracker = TM::ProjectTracker.new
  employee = tracker.add_new_employee("Parth")
  expect(employee.name).to eq("Parth")
  expect(employee.id).to eq(1)
  expect(tracker.employees.count).to eq(1)
  employee_two = tracker.add_new_employee("John")
  expect(employee_two.id).to eq(2)
  expect(employee_two.name).to eq("John")
  expect(tracker.employees.count).to eq(2)
end
end






