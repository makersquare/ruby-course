require 'spec_helper'

describe TM::Database do
	before do
		@db = TM.db
	end

	describe ".initialize" do
		it "defaults a list of projects with no projects on it" do
			expect(@db.all_projects).to eq([])
		end
	end

	it "creates a project" do
		project = @db.create_project('sxsw')
		project_list = @db.all_projects

		expect(project_list.first.id).to eq(project.id)
	end

	context "A project with a task" do
		before do
			@project = @db.create_project('sxsw')
			@task = @db.add_task(@project.id, 2, 'Arrange bands')
		end

		it "should create a task and add it to a project" do
			expect(@task.project_id).to eq(@project.id)

			# Ensure @task is stored on db
			retrieved_task = @db.get_task(@task.id)
			expect(retrieved_task.description).to eq 'Arrange bands'
			expect(retrieved_task.priority).to eq(2)
		end

		it "shows incomplete tasks given project ID, sorted by priority and creation time" do
			Time.stub(:now).and_return(Time.parse('1pm'))
			task_eat = @db.add_task(@project.id, 1, 'eat')
			Time.stub(:now).and_return(Time.parse('8pm'))
			task_sleep = @db.add_task(@project.id, 1, 'sleep')
			incomplete_tasks = @db.show_incomplete(@project.id)

			expect(incomplete_tasks.count).to eq(3)
			expect(incomplete_tasks[0].id).to eq(task_eat.id)
			expect(incomplete_tasks[1].id).to eq(task_sleep.id)
			expect(incomplete_tasks[2].id).to eq(@task.id)
		end

		it "shows completed tasks given project ID, sorted by creation time" do
			Time.stub(:now).and_return(Time.parse('1pm'))
			task_eat = @db.add_task(@project.id, 1, 'eat')
			Time.stub(:now).and_return(Time.parse('8pm'))
			task_sleep = @db.add_task(@project.id, 1, 'sleep')
			Time.stub(:now).and_return(Time.parse('9am'))
			task_shower = @db.add_task(@project.id, 3, 'shower')
			completed_tasks = @db.show_complete(@project.id)

			expect(completed_tasks.first).to eq(nil)

			@db.mark_task_complete(task_eat.id)
			@db.mark_task_complete(task_shower.id)
			
			# Query database for completed tasks after marking them complete
			new_completed_tasks = @db.show_complete(@project.id)

			expect(new_completed_tasks.count).to eq(2)
			expect(new_completed_tasks.first.id).to eq(task_shower.id)
			expect(new_completed_tasks.last.id).to eq(task_eat.id)
		end

		it "should change the complete status of a task to true" do
			task_list = @db.all_tasks
			expect(task_list.first.complete).to be_false

			@db.mark_task_complete(@task.id)
			expect(task_list.first.complete).to be_true
		end
	end
end