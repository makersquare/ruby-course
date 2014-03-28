require 'spec_helper'

describe 'Tracker' do
  it "exists" do
    expect(TM::Database).to be_a(Class)
  end
  before do
      @tracker = TM.database
  end
  it "initializes with an empty hash of list of projects, tasks, employees, and membership" do
   expect(@tracker.projects).to be_a(Hash)
   expect(@tracker.tasks).to be_a(Hash)
   expect(@tracker.employees).to be_a(Hash)
   expect(@tracker.membership).to be_a(Array)
  end

  it "allows you to add a project and you can get the projects" do
     project = @tracker.create_new_project("blue")
     @tracker.create_new_project("red")
     expect(@tracker.projects[project.id].id).to eq(project.id)
     project = @tracker.create_new_project("blue")
      expect(@tracker.get_project(project.id).id).to eq(project.id)
   end

  it "allows you to add an employee and get the employee" do
    employee = @tracker.add_new_employee("Parth")
    expect(employee.name).to eq("Parth")
    expect(@tracker.get_employee(employee.id).name).to eq (employee.name)
  end

  it "allows you to add a task and get a task" do
    task = @tracker.add_task(1, 5, "yellow description")
    result = @tracker.get_task(task.id)
    expect(result.description).to eq(task.description)
  end
end



















