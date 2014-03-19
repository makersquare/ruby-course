require 'spec_helper'

describe "TM::ProjectList" do
	before  do
		TM::Project.class_variable_set :@@project_id, 1
		@pl = TM::ProjectList.new
		@new_project = @pl.create_project("cool project")
	end

	it "can get a project based on the project ID" do
		expect(@pl.get_project(1)).to eq(@new_project)
	end

	it "exists" do
		expect(TM::ProjectList).to be_a(Class)
	end

	it "can create projects" do
		expect(@new_project).to eq(@pl.project_list[0])
	end

end