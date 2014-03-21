require 'spec_helper'

describe 'Project' do
	before do
		@project = TM::Project.new("website")
		@project.add_task("cool task")
		@project.add_task("cooler task")
		@project.add_task("coolest task")
	end

	it "exists" do
		expect(TM::Project).to be_a(Class)
	end

	it "has a name" do
		expect(@project.name).to eq("website")
	end

	it "initializes with a unique ID" do
		TM::Project.class_variable_set :@@project_id, 0
		@new_project = TM::Project.new("cooler project")
		@coolest_project = TM::Project.new("coolest project")
		expect(@new_project.project_id).to eq(0)
		expect(@coolest_project.project_id).to eq(1)
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
		expect(@project.tasks[0]).to receive(:task_id).and_return(1)
		expect(@project.tasks[1]).to receive(:task_id).and_return(2)
		expect(@project.complete_task(1)).to eq("complete")
	end

	it "can retrieve a list of all complete tasks" do
		expect(@project.completed_tasks).to be_an(Array)
	end

	# it "returns completed tasks ordered by creation date" do
	# 	expect(@projects.completed_tasks).should_be_sorted_by
	# end


end
