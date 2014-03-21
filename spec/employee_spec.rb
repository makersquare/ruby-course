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
  end
end