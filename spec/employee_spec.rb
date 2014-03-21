require 'spec_helper'

describe 'Employee' do
  
  before do
    @emp = TM::Employee.new('Pim')
  end

  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

  describe '.initialize' do
    it "gives a name" do
      expect(@emp.name).to eq("Pim")
    end

    it "generates and assigns a unique id" do
      TM::Employee.class_variable_set :@@counter, 0
      expect(TM::Employee.new('Estevan').id).to eq(1)
      expect(TM::Employee.new('Estevan').id).to eq(2)
      expect(TM::Employee.new('Estevan').id).to eq(3)
    end
  end
end