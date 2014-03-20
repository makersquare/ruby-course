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

end
