require 'spec_helper'

describe TM::Database do
	before do
		@db = TM.db
	end

	describe ".initialize" do
		it "defaults a list of projects with no projects on it" do
			expect(@db.all_projects).to eq([])
		end

		it "defaults a list of tasks with no tasks on it" do
			expect(@db.all_tasks).to eq([])
		end

		it "defaults a list of employees with no employees on it" do
			expect(@db.all_employees).to eq([])
		end

		it "defaults a list of project and employee relationships" do
			expect(@db.memberships).to eq([])
		end
	end

	describe ".create_project" do
		it "creates a project" do
			project = @db.create_project('sxsw')
			project_list = @db.all_projects

			expect(project_list.first.id).to eq(project.id)
		end
	end

	describe ".create_employee" do
		it "creates an employee" do
			employee = @db.create_employee('Alice')
			employee_list = @db.all_employees

			expect(employee_list.first.id).to eq(employee.id)
		end
	end

	context "A project with a task" do
		before do
			@project = @db.create_project('sxsw')
			@task = @db.create_task(@project.id, 2, 'Arrange bands')
		end

		describe ".create_task" do
			it "should create a task and add it to a project" do
				expect(@task.project_id).to eq(@project.id)

				# Ensure @task is stored on db
				retrieved_task = @db.get_task(@task.id)
				expect(retrieved_task.description).to eq 'Arrange bands'
				expect(retrieved_task.priority).to eq(2)
			end
		end

		describe ".project_incomplete" do
			it "shows incomplete tasks given project ID, sorted by priority and creation time" do
				Time.stub(:now).and_return(Time.parse('1pm'))
				task_eat = @db.create_task(@project.id, 1, 'eat')
				Time.stub(:now).and_return(Time.parse('8pm'))
				task_sleep = @db.create_task(@project.id, 1, 'sleep')
				incomplete_tasks = @db.project_incomplete(@project.id)

				expect(incomplete_tasks.count).to eq(3)
				expect(incomplete_tasks[0].id).to eq(task_eat.id)
				expect(incomplete_tasks[1].id).to eq(task_sleep.id)
				expect(incomplete_tasks[2].id).to eq(@task.id)
			end
		end

		describe ".project_complete" do
			it "shows completed tasks given project ID, sorted by creation time" do
				Time.stub(:now).and_return(Time.parse('1pm'))
				task_eat = @db.create_task(@project.id, 1, 'eat')
				Time.stub(:now).and_return(Time.parse('8pm'))
				task_sleep = @db.create_task(@project.id, 1, 'sleep')
				Time.stub(:now).and_return(Time.parse('9am'))
				task_shower = @db.create_task(@project.id, 3, 'shower')
				completed_tasks = @db.project_complete(@project.id)

				expect(completed_tasks.first).to eq(nil)

				@db.mark_task_complete(task_eat.id)
				@db.mark_task_complete(task_shower.id)
				
				# Query database for completed tasks after marking them complete
				new_completed_tasks = @db.project_complete(@project.id)

				expect(new_completed_tasks.count).to eq(2)
				expect(new_completed_tasks.first.id).to eq(task_shower.id)
				expect(new_completed_tasks.last.id).to eq(task_eat.id)
			end
		end

		describe ".mark_task_complete" do
			it "should change the complete status of a task to true" do
				task_list = @db.all_tasks
				expect(task_list.first.complete).to be_false

				@db.mark_task_complete(@task.id)
				expect(task_list.first.complete).to be_true
			end
		end
	end

	context "Several projects, employees and tasks" do
		before do
			@project1 = @db.create_project('sxsw')
			@project2 = @db.create_project('build app')
			@employee1 = @db.create_employee('Alice')
			@employee2 = @db.create_employee('Bob')
			@task1 = @db.create_task(@project1.id, 2, 'Arrange bands')
			@task2 = @db.create_task(@project2.id, 2, 'Set up rails')
		end

		describe ".recruit" do
			it "should create a relationship between a project and an employee" do
				expect(@db.memberships).to eq([])
				expect(@db.memberships.count).to eq(0)

				@db.recruit(@project1.id, @employee1.id)
				expect(@db.memberships.count).to eq(1) 
			end
		end
	end
end