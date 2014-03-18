require 'spec_helper'

describe 'Project' do
	it "exists" do
		expect(TM::Project).to be_a(Class)
	end

	it "has a name" do
		project = TM::Project.new("website")
		expect(project.name).to eq("website")
	end
end
