require 'spec_helper'

describe 'Employee' do
  before do
    @new_employee = TM::Employee.new('brandon')
  end

  it 'exists' do
    expect(TM::Employee).to be_a(Class)
  end

  it 'is initialized with a name' do
    result = @new_employee.name
    expect(result).to eq 'brandon'
  end

  it 'automatically assigns a unique id' do
    result = @new_employee.id
    expect(result).to eq 2

  end
end
