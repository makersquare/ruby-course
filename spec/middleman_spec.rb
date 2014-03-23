require 'spec_helper'

describe 'Middleman' do

  before do
    @project1 = TM::Project.new("Kill Jim")
    @task1 = TM::Task.new(@project1.id, "Buy gun", 4)
  end


  it "can create a Task" do
    new_task = TM::Middleman.create_task(@project1.id,"Load the gun", 7)
    expect(TM::DB.instance.all_tasks).to have_key(new_task.task_id)
  end

  it "can mark a task as finished" do
    TM::Middleman.mark_task(@task1.task_id)
    expect(@task1.finished?).to eq(true)
  end

  it "can return a list of the employees assigned to a particular project" do
    project2 = TM::Project.new("Kill Jamie")
    new_employee1 = TM::Employee.new("Bill")
    new_employee2 = TM::Employee.new("Sue")
    new_employee3 = TM::Employee.new("Jim")
    new_employee4 = TM::Employee.new("Bobby")

    TM::DB.instance.assign_project(@project1, new_employee1)
    TM::DB.instance.assign_project(project2, new_employee2)
    TM::DB.instance.assign_project(@project1, new_employee3)
    TM::DB.instance.assign_project(@project1, new_employee4)
    TM::DB.instance.assign_project(project2, new_employee4)

    employee_list1 = TM::Middleman.get_assigned_employees(@project1.id)
    employee_list2 = TM::Middleman.get_assigned_employees(project2.id)

    expect(employee_list1.include?(new_employee1)).to eq(true)
    expect(employee_list1.include?(new_employee3)).to eq(true)
    expect(employee_list1.include?(new_employee4)).to eq(true)

    expect(employee_list2.include?(new_employee2)).to eq(true)
    expect(employee_list2.include?(new_employee4)).to eq(true)

    expect(employee_list1.length).to eq(3)
    expect(employee_list2.length).to eq(2)
  end

  it "can assign a task to an employee" do
    project2 = TM::Project.new("Kill Jamie")
    new_employee1 = TM::Employee.new("Bill")
    TM::DB.instance.assign_project(@project1, new_employee1)
    TM::Middleman.assign_task_to_employee(@task1.task_id, new_employee1.employee_id)
    expect(new_employee1.tasks[@task1.task_id]).to eq(@task1)
  end



end
