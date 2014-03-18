require 'spec_helper'

describe 'Project' do
	before do
		@project = TM::Project.new("SXSW")
	end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "should be initialized with a name" do
  	expect(@project.name).to eq 'SXSW'
  end

  it "should be initialized with a unique id" do
  	# The id here is 3 because two instances of Project were created before
  	expect(@project.id).to eq(3)
  end
end
