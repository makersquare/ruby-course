require 'spec_helper'

describe 'Project' do
	before do
		@project = TM::Project.new("SXSW")
	end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe ".initialize" do
	  it "should be initialized with a name" do
	  	expect(@project.name).to eq 'SXSW'
	  end

	  it "should be initialized with a unique id" do
	  	TM::Project.class_variable_set :@@id_counter, 0
	  	expect(TM::Project.new("Project1").id).to eq(1)
	    expect(TM::Project.new("Project2").id).to eq(2)
	    expect(TM::Project.new("Project3").id).to eq(3)
	  end
	end
end
