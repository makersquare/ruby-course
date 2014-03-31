require 'spec_helper'

describe 'Employee' do
  before do
    TM::Employee.class_variable_set :@@counter, 0
    @new_employee = TM::Employee.new('moe')

  end
  it 'exists' do
    expect(TM::Employee).to be_a(Class)
  end

  describe '.initialize' do
    it 'is created with a name' do

      result = @new_employee.name
      expect(result).to eq('moe')

    end
    it 'automically assigns this employee an id' do

      result = @new_employee.id

      expect(result).to eq(1)

    end
  end

end
