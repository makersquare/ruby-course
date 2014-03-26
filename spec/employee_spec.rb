require 'spec_helper'

describe 'Employee' do
  it 'exists' do
    expect(TM::Employee).to be_a(Class)
  end

  describe '.initialize' do
    it 'is created with a name' do
      name = 'bob'
      new_employee = TM::Employee.new(name)

      result = new_employee.name
      expect(result).to eq(name)

    end
    it 'automically assigns this employee an id' do

    end
  end

end
