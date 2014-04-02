require 'spec_helper'

describe 'Employee' do
	before do
		@employee = TM::Employee.new("Alice")
	end

  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

  describe ".initialize" do
	  it "should be initialized with a name" do
	  	expect(@employee.name).to eq 'Alice'
	  end

	  it "should be initialized with a unique id" do
	  	TM::Employee.class_variable_set :@@id_counter, 0
	  	expect(TM::Employee.new("Alice").id).to eq(1)
	    expect(TM::Employee.new("Bob").id).to eq(2)
	    expect(TM::Employee.new("Carl").id).to eq(3)
	  end
	end
end