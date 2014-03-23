require 'spec_helper'

describe 'Project' do

  it "initiates with blank employees(hash), participating(array), projects(hash), tasks(array)" do
    expect(TM::DB.instance.all_employees).to be_a(Hash)
    expect(TM::DB.instance.all_tasks).to be_a(Hash)
    expect(TM::DB.instance.all_projects).to be_a(Hash)
  end

  it "can allow access to its hashes and arrays" do
    TM::DB.instance.all_employees[:bob] = 5
    expect(TM::DB.instance.all_employees[:bob]).to eq(5)
  end

  before do
    @bob = TM::Employee.new("Bob")
    @sue = TM::Employee.new("Sue")
    @project = TM::Project.new("Kill Bill")
    @task = TM::Task.new(@project.id, "Buy gun", 8)
  end

  it "can assign projects to an employee" do
    TM::DB.instance.assign_project(@project, @bob)
    expect(TM::DB.instance.project_assigned?(@project, @bob)).to eq(true)
    expect(TM::DB.instance.project_assigned?(@project, @sue)).to eq(false)
  end

  it "can check to see if an employee is assigned to a project" do
    TM::DB.instance.project_assignments << { employee_id: @bob.employee_id,
                                              project_id: @project.id,
                                              employee: @bob,
                                              project: @project }
    expect(TM::DB.instance.project_assigned?(@project, @bob)).to eq(true)
    expect(TM::DB.instance.project_assigned?(@project, @sue)).to eq(false)
  end

  it "can assign a task to an employee & then check that assignment" do
    TM::DB.instance.assign_project(@project, @bob)
    TM::DB.instance.assign_task(@task, @bob)
    expect(TM::DB.instance.task_assigned?(@task, @bob)).to eq(true)
    expect(TM::DB.instance.task_assigned?(@task, @sue)).to eq(false)
  end

  it "can return an array of tasks assigned to an employee" do
    employee1 = TM::Employee.new("Bobby")
    project1 = TM::Project.new("Kill Bob")
    task1 = TM::Task.new(project1.id, "Buy gun", 3)
    task2 = TM::Task.new(project1.id, "Load gun", 4)
    task3 = TM::Task.new(project1.id, "Aim gun", 5)
    TM::DB.instance.assign_project(project1, employee1)
    TM::DB.instance.assign_task(task1, employee1)
    TM::DB.instance.assign_task(task2, employee1)
    TM::DB.instance.assign_task(task3, employee1)
    expect(TM::DB.instance.employee_tasks(employee1).length).to eq(3)
  end

    it "can return an array of ongoing tasks" do
    employee1 = TM::Employee.new("Bobby")
    project1 = TM::Project.new("Kill Bob")
    project2 = TM::Project.new("Kill Sam")
    task1 = TM::Task.new(project1.id, "Buy gun", 3)
    task2 = TM::Task.new(project1.id, "Load gun", 4)
    task3 = TM::Task.new(project1.id, "Aim gun", 5)
    TM::DB.instance.assign_project(project1, employee1)
    TM::DB.instance.assign_task(task1, employee1)
    TM::DB.instance.assign_task(task2, employee1)
    TM::DB.instance.assign_task(task3, employee1)
    expect(TM::DB.instance.ongoing_tasks(employee1).length).to eq(3)
  end

  it "can return an array of finished tasks" do
    employee1 = TM::Employee.new("Bobby")
    project1 = TM::Project.new("Kill Bob")
    project2 = TM::Project.new("Kill Sam")
    task1 = TM::Task.new(project1.id, "Buy gun", 3)
    task2 = TM::Task.new(project1.id, "Load gun", 4)
    task3 = TM::Task.new(project1.id, "Aim gun", 5)
    TM::DB.instance.assign_project(project1, employee1)
    TM::DB.instance.assign_task(task1, employee1)
    TM::DB.instance.assign_task(task2, employee1)
    TM::DB.instance.assign_task(task3, employee1)
    task1.finished = true
    task2.finished = true
    expect(TM::DB.instance.completed_tasks(employee1).length).to eq(2)
  end



end
