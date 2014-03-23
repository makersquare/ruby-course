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

  it "can assign a task to an employee" do
    new_employee1 = TM::Employee.new("Bill")
    new_task = TM::Task.new(@project1.id, "Bla bla bla", 8)
    TM::DB.instance.assign_project(@project1, new_employee1)
    TM::Middleman.assign_task_to_employee(new_task.task_id, new_employee1.employee_id)

    expect(TM::DB.instance.task_assigned?(new_task, new_employee1)).to eq(true)
  end

  it "can create an employee" do
    new_employee = TM::Middleman.create_employee("Bob")

    expect(TM::DB.instance.all_employees[new_employee.employee_id]).to eq(new_employee)
  end


end
