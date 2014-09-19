require 'spec_helper'

describe "Managing Memberships" do

  before do
    PM.employees.delete_all
    PM.projects.delete_all
    PM.memberships.delete_all

    @alice = PM::Employee.new("Alice", "alice@example.com", 20)
    PM.employees.save(@alice)

    @bob = PM::Employee.new("Bob", "bob@example.com", 15)
    PM.employees.save(@alice)

    @code_red = PM::Project.new("Code Red", "urgent")
    PM.projects.save(@code_red)

    PM.memberships.create(@code_red, @alice, 'manager')
    PM.memberships.create(@code_red, @bob, 'worker')
  end

  it "returns employees by project id" do
    employees = PM.employees.all_by_project_id(@code_red.id)
    expect(employees.count).to eq 2
    expect(employees.map &:id).to include(@alice.id, @bob.id)
    expect(employees.map &:name).to include('Alice', 'Bob')
  end

  it "returns a projects by user id" do
    projects = PM.projects.all_by_employee_id(@code_red.id)
    expect(projects.count).to eq 1
    expect(projects.first.id).to eq @code_red.id
  end

  it "deletes a membership" do
    PM.memberships.delete(@code_red, @bob)

    employees = PM.employees_repo.all_by_project_id(red.id)
    expect(employees.count).to eq 1
    expect(employees.first.id).to eq @bob.id
  end
end
