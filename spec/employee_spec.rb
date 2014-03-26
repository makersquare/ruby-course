require 'spec_helper'

describe 'Employee' do
  before do
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

      expect(result).to eq(2)

    end
  end

end
