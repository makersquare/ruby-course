require 'spec_helper'

describe 'ProjectList' do
	before do
		@project_list = TM::ProjectList.new
		@project = @project_list.create_project('sxsw')
		@pid = @project.id
	end

	describe "create_project" do
		it "creates an instance of TM::Project and saves it in a projects list" do
			expect(@project_list.projects.count).to eq(1)
		end
	end

	describe "add_task" do
		it "add a task to a project" do
			sleep = @project_list.add_task(@pid, 4, 'sleep')
			expect(@project.tasks.first).to eq(sleep)
		end
	end

	describe "mark_task_complete" do
		it "should change the status of a task to 'complete'" do
			cook_task = @project_list.add_task(@pid, 3, 'cook dinner')
			expect(@project.tasks.first.status).to eq 'incomplete'

			@project_list.mark_task_complete(cook_task.id)
			expect(@project.tasks.first.status).to eq 'complete'
		end
	end

	describe "show_incomplete" do
		it "returns remaining tasks for a project based on project id" do
			wash_task = @project_list.add_task(@pid, 4, 'wash clothes')
			expect(@project_list.show_incomplete(@pid).first).to eq(wash_task)
		end
	end

	describe "show_complete" do
		it "returns completed tasks for a project based on project id" do
			cook_task = @project_list.add_task(@pid, 3, 'cook dinner')
			expect(@project_list.show_complete(@pid).first).to eq(nil)

			@project_list.mark_task_complete(cook_task.id)
			expect(@project_list.show_complete(@pid).first).to eq(cook_task)
		end
	end
end