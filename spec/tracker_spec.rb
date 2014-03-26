require 'spec_helper'

describe 'Tracker' do
  it "exists" do
    expect(TM::Database).to be_a(Class)
  end
  before do
      @tracker = TM::Database.new
  end
  it "initializes with an empty hash of list of projects, tasks, employees, and membership" do
   expect(@tracker.projects).to eq({})
   expect(@tracker.tasks).to eq({})
   expect(@tracker.employees).to eq({})
   expect(@tracker.membership).to eq({})
  end
  xit "only initializes one instance of the database" do
  end

end

#   it "allows you to add a project and that project is stored in the projects array" do
#     tracker = TM::Database.new
#     expect(tracker.projects).to eq([])
#     tracker.create_new_project("blue")
#     tracker.create_new_project("red")
#     expect(tracker.projects.count).to eq(2)
#     expect(tracker.projects.first.name).to eq("blue")
#   end

# it "tests the ability to add tasks to a project" do
#   TM::Project.id_counter = 1
#   tracker = TM::Database.new
#   expect(tracker.add_task("5", "yellow", "7")).to eq(nil)
#   project = tracker.create_new_project("project")
#   expect(tracker.projects.count).to eq(1)
#   expect(tracker.projects.first.id).to eq(1)
#   tracker.add_task("1", "yellow", "7")
#   expect(tracker.tasks.count).to eq(1)
#   expect(project.tasks.count).to eq(1)
# end

# it "allows you to complete a task" do
#   TM::Project.id_counter = 1
#   TM::Task.id_counter = 1
#   tracker = TM::Database.new
#   tracker.create_new_project("project")
#   blue = tracker.add_task("1", "yellow", "7")
#   tracker.complete_task(1)
#   expect(blue.status).to eq("complete")
# end

# it "allows you to create a new employee from tracker" do
#   TM::Employee.id_counter = 1
#   tracker = TM::Database.new
#   employee = tracker.add_new_employee("Parth")
#   expect(employee.name).to eq("Parth")
#   expect(employee.id).to eq(1)
#   expect(tracker.employees.count).to eq(1)
#   employee_two = tracker.add_new_employee("John")
#   expect(employee_two.id).to eq(2)
#   expect(employee_two.name).to eq("John")
#   expect(tracker.employees.count).to eq(2)
# end

# it "should print the id and names of all employees" do
#   TM::Employee.id_counter = 1
#   tracker = TM::Database.new
#   expect(tracker.employees).to eq([])
#   employee = tracker.add_new_employee("Parth")
#   expect(tracker.employees.count).to eq(1)
#   employee = tracker.add_new_employee("Parth")
#   expect(tracker.employees.count).to eq(2)
# end

# it "assigns a task to an employee" do
#   TM::Employee.id_counter = 1
#   TM::Task.id_counter = 1
#   TM::Project.id_counter = 1
#   tracker = TM::Database.new
#   employee_one = tracker.add_new_employee("Parth")
#   employee_two = tracker.add_new_employee("John")
#   tracker.create_new_project("project")
#   task_one = tracker.add_task("1", "yellow", "7")
#   expect(task_one.employee).to eq(nil)
#   tracker.assign_task(1, 1)
#   expect(task_one.employee).to eq(employee_one)
#   tracker.assign_task(1, 2)
#   expect(task_one.employee).to eq(employee_two)
#   expect(employee_two.tasks.first.description).to eq("yellow")
# end

# it "can assign employees to a project" do
#   TM::Employee.id_counter = 1
#   TM::Task.id_counter = 1
#   TM::Project.id_counter = 1
#   tracker = TM::Database.new
#   blue = tracker.create_new_project("project")
#   red = tracker.create_new_project("red")
#   employee_one = tracker.add_new_employee("Parth")
#   expect(tracker.assign_to_project(2, 3)).to eq(nil)
#   tracker.assign_to_project(1, 1)
#   expect(blue.employees.count).to eq(1)
#   expect(blue.employees.first.name).to eq("Parth")
#   employee_two = tracker.add_new_employee("John")
#   tracker.assign_to_project(1, 2)
#   tracker.assign_to_project(2, 1)
#   expect(blue.employees.count).to eq(2)
#   expect(employee_one.projects.first).to eq(blue)
#   expect(employee_two.projects.first).to eq(blue)
#   expect(employee_one.projects[1]).to eq(red)
# end

#   it "returns incomplete tasks of employee" do
#   TM::Employee.id_counter = 1
#   TM::Task.id_counter = 1
#   TM::Project.id_counter = 1
#   tracker = TM::Database.new
#   project = tracker.create_new_project("project")
#   employee_one = tracker.add_new_employee("Parth")
#   task_one = tracker.add_task("1", "yellow", "7")
#   task_two = tracker.add_task("1", "blue", "5")
#   tracker.assign_task(1, 1)
#   tracker.assign_task(2, 1)
#   expect(tracker.remaining_employee_tasks(1).count).to eq(2)
#   end

#   it "returns complete tasks of employee" do
#   TM::Employee.id_counter = 1
#   TM::Task.id_counter = 1
#   TM::Project.id_counter = 1
#   tracker = TM::Database.new
#   project = tracker.create_new_project("project")
#   employee_one = tracker.add_new_employee("Parth")
#   task_one = tracker.add_task("1", "yellow", "7")
#   task_two = tracker.add_task("1", "blue", "5")
#   tracker.assign_task(1, 1)
#   tracker.assign_task(2, 1)
#   expect(tracker.remaining_employee_tasks(1).count).to eq(2)
#   tracker.complete_task(1)
#   expect(tracker.remaining_employee_tasks(1).count).to eq(1)
#   expect(tracker.completed_employee_tasks(1).count).to eq(1)
#   tracker.complete_task(2)
#   expect(tracker.completed_employee_tasks(1).count).to eq(2)
#   end
# end





















