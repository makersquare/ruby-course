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

	it "can can mark tasks as complete, specified by id" do
		# expect(@project.tasks.find {|x| x.object_id == 1}).to eq(true)
		expect(@project.tasks[0]).to receive(:task_id).and_return(1)
		# binding.pry
		expect(@project.complete_task(1)).to eq("complete")
	end
end
