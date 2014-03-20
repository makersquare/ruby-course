require 'spec_helper'

describe 'Employee' do
  it 'exists' do
  expect(TM::Employee).to be_a(Class)
  end
  it 'initializes an employee with a name and unique id' do
    TM::Employee.id_counter = 1
    employee_one = TM::Employee.new("Parth")
    expect(employee_one.name).to eq("Parth")
    expect(employee_one.id).to eq(1)
  end
end
