require 'spec_helper'

describe 'Employee' do
  it 'exists' do
    expect(TM::Employee).to be_a(Class)
  end

  it 'is initialized with a name' do
    name = "brandon"
    new_employee = TM::Employee.new(name)
    result = new_employee.name
    expect(result).to eq "brandon"
  end
end
