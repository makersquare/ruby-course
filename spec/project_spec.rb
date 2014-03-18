require 'spec_helper'

describe 'Project' do
	before do
		@project = TM::Project.new("website")
		@project.add_task("cool task")
	end

	it "exists" do
		expect(TM::Project).to be_a(Class)
	end

	it "has a name" do
		expect(@project.name).to eq("website")
	end

	it "initializes with a unique ID" do
		expect(@project.project_id).to eq(@project.object_id)
	end

	it "creates a task with a project id" do
		expect(@project.tasks[0].project_id).to eq(@project.project_id)
	end

	it "creates a task with a description" do
		expect(@project.tasks[0].description).to eq("cool task")
	end

	it "creates a task with a priority number" do
		expect(@project.tasks[0].priority).to eq(3)
	end

	xit "can can mark tasks as complete, specified by id" do
		expect(@project.tasks[0]).to eq(true)
	end
end
