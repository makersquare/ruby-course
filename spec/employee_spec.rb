require 'spec_helper'

describe 'employee' do

  it "can be created with a name" do
    employee1 = TM::Employee.new("Bobby")
    expect(employee1.name).to eq("Bobby")
  end

  it "must automatically generate and assign unique id" do
    employee1 = TM::Employee.new("Bobby")
    employee2 = TM::Employee.new("Tammy")
    expect(employee2.employee_id).to eq(employee1.employee_id + 1)
  end

  it "should add itself to the list of all_employees" do
    employee1 = TM::Employee.new("Bobby")
    employee2 = TM::Employee.new("Tammy")
    expect(TM::DB.instance.all_employees[employee2.employee_id]).to eq(employee2)
  end

  it "can add multiple employees to a single project" do
    employee1 = TM::Employee.new("Bobby")
    employee2 = TM::Employee.new("Tammy")
    project1 = TM::Project.new("Kill Bob")
  end

  it "can be assigned to multiple projects" do
    employee1 = TM::Employee.new("Bobby")
    employee2 = TM::Employee.new("Tammy")
    project1 = TM::Project.new("Kill Bob")
    project2 = TM::Project.new("Kill Sam")

    TM::DB.instance.assign_project(project1, employee1)
    TM::DB.instance.assign_project(project2, employee1)
    expect(TM::DB.instance.project_assigned?(project1, employee1)).to eq(true)
    expect(TM::DB.instance.project_assigned?(project2, employee1)).to eq(true)

  end

  it "can accept a task if it's already assigned to a project" do
    employee1 = TM::Employee.new("Bobby")
    project1 = TM::Project.new("Kill Bob")
    task1 = TM::Task.new(project1.id, "Buy gun", 3)
    TM::DB.instance.assign_project(project1, employee1)
    TM::DB.instance.assign_task(task1, employee1)
    expect(TM::DB.instance.task_assigned?(task1, employee1)).to eq(true)
  end

  it "does not add the task if the project has not been assigned" do
    employee1 = TM::Employee.new("Bobby")
    project1 = TM::Project.new("Kill Bob")
    project2 = TM::Project.new("Kill Sam")
    task1 = TM::Task.new(project1.id, "Buy gun", 3)
    TM::DB.instance.assign_project(project2, employee1)
    TM::DB.instance.task_assigned?(task1, employee1)
    expect(TM::DB.instance.task_assigned?(task1, employee1)).to eq(false)

    TM::DB.instance.assign_project(project1, employee1)
    TM::DB.instance.assign_task(task1, employee1)
    expect(TM::DB.instance.task_assigned?(task1, employee1)).to eq(true)
  end




end
