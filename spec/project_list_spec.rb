require 'spec_helper'
require 'pry-debugger'

describe "TM::ProjectList" do
	before  do
		@pl = TM::ProjectList.new
	end

	it "exists" do
		expect(TM::ProjectList).to be_a(Class)
	end

	it "can create projects" do
		new_project = @pl.create_project("cool project")
		expect(new_project).to eq(@pl.project_list)
	end
end