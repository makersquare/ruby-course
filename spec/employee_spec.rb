require 'spec_helper'
require 'pry'

describe 'Employee' do
  before(:each) do
    @db = TM.db
    @db.create_employee(name: "Jason")
    @db.create_project(name: "New Project")
    @db.create_project(name: "New Two")
    @employee1 = @db.get_employee(1)
  end

  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

  it 'can show all projects an employee is on' do
    @db.create_membership(pid: 1, eid: 1)
    @db.create_membership(pid: 2, eid: 1)

    expect(@employee1.show_projects.count).to eq(2)
    expect(@employee1.show_projects.first.name).to eq("New Project")
    expect(@employee1.show_projects.last.id).to eq(2)
  end

  it 'can show all remaining task and project ID' do
    @db.create_task(description: "Task 1", priority: 1, pid: 2)
    @db.create_task(description: "Task 2", priority: 2, pid: 1)
    @db.create_membership(eid: 1, pid: 1)
    @db.create_membership(eid: 1, pid: 2)
    @db.get_task(1).assign_employee(:eid => 1)
    @db.get_task(2).assign_employee(:eid => 1)
    # binding.pry

    expect(@employee1.show_task(completed: false).first.pid).to eq(2)
    expect(@employee1.show_task(completed: false).last.description).to eq("Task 2")
  end

  it 'can show all completed task' do
    @db.create_task(description: "Task 1", priority: 1, pid: 2)
    @db.create_task(description: "Task 2", priority: 2, pid: 1)
    @db.create_membership(eid: 1, pid: 1)
    @db.create_membership(eid: 1, pid: 2)
    @db.get_task(1).assign_employee(:eid => 1)
    @db.get_task(2).assign_employee(:eid => 1)
    @db.get_task(1).complete_task

    # binding.pry
    expect(@employee1.show_task(completed: true).first.pid).to eq(2)
  end

end
