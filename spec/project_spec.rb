require 'spec_helper'

describe 'Project' do
	before do
		@project = TM::Project.new("website")
	end
	
	it "exists" do
		expect(TM::Project).to be_a(Class)
	end

	it "has a name" do
		expect(@project.name).to eq("website")
	end

	it "initializes with a unique ID" do
		expect(@project.id).to eq(@project.object_id)
	end
end
