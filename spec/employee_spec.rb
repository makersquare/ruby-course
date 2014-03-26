require 'spec_helper'

describe 'Employee' do
  it 'exist' do
    expect(TM::Employee).to be_a(Class)
  end

  describe '.initialize' do
    it 'sets a name for Employee' do
      emp = TM::Employee.new('Bob')

      expect(emp.name).to eq('Bob')
    end

    it 'sets a unique id for each employee' do

      TM::Employee.class_variable_set :@@id_counter, 0

      expect(TM::Employee.new("John1").employee_id).to eq(1)
      expect(TM::Employee.new("John2").employee_id).to eq(2)
      expect(TM::Employee.new("John3").employee_id).to eq(3)
    end

  end
end
