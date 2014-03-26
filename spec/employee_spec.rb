require 'spec_helper'
describe "Employee" do
  it "Can be create with a name" do
    guy = TM::Employee.new("A guy")
    expect(guy.name).to eq("A guy")
  end

  it "Automatically generates and assigns a unique id" do
    newguy = TM::Employee.new("Name")
    expect(newguy.employee_id).to be_a(Integer)
  end

  it "Employee can be added to project" do
    newguy = TM::Employee.new("Name")
    project = TM::Project.new("Project")
    project.addemployee(newguy)
    expect(project.employees_on_project.first).to be_a(TM::Employee)
  end

  # it "Tasks can be assigned to employee if he is on the project" do
  #   project = TM::Project.new("Project")
  #   newguy = TM::Employee.new("Name")
  #   project.addemployee(newguy)
  #   project.addtask("Task",1)
  #   project.assigntask(project.tasks[1], newguy)
  #   expect(newguy.tasks.first).to be_a(TM::Task)
  # end
end
