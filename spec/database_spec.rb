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

			expect(project_list.count).to eq(1)
			expect(project_list.first.id).to eq(project.id)
		end
	end

	describe ".create_employee" do
		it "creates an employee" do
			employee = @db.create_employee('Alice')
			employee_list = @db.all_employees

			expect(employee_list.count).to eq(1)
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

		describe ".project_incomplete_tasks" do
			it "shows incomplete tasks given project ID, sorted by priority and creation time" do
				Time.stub(:now).and_return(Time.parse('1pm'))
				task_eat = @db.create_task(@project.id, 1, 'eat')
				Time.stub(:now).and_return(Time.parse('8pm'))
				task_sleep = @db.create_task(@project.id, 1, 'sleep')
				incomplete_tasks = @db.project_incomplete_tasks(@project.id)

				expect(incomplete_tasks.count).to eq(3)
				expect(incomplete_tasks[0].id).to eq(task_eat.id)
				expect(incomplete_tasks[1].id).to eq(task_sleep.id)
				expect(incomplete_tasks[2].id).to eq(@task.id)
			end
		end

		describe ".project_complete_tasks" do
			it "shows completed tasks given project ID, sorted by creation time" do
				Time.stub(:now).and_return(Time.parse('1pm'))
				task_eat = @db.create_task(@project.id, 1, 'eat')
				Time.stub(:now).and_return(Time.parse('8pm'))
				task_sleep = @db.create_task(@project.id, 1, 'sleep')
				Time.stub(:now).and_return(Time.parse('9am'))
				task_shower = @db.create_task(@project.id, 3, 'shower')
				completed_tasks = @db.project_complete_tasks(@project.id)

				expect(completed_tasks.first).to eq(nil)

				@db.mark_task_complete(task_eat.id)
				@db.mark_task_complete(task_shower.id)
				
				# Query database for completed tasks after marking them complete
				new_completed_tasks = @db.project_complete_tasks(@project.id)

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

		describe ".assign_task_to_emp" do
			it "should assign a task to an employee based on their ids" do
				task = @db.assign_task_to_emp(@task2.id, @employee1.id)
				expect(task.employee_id).to_not eq(nil)
				expect(task.employee_id).to eq(@employee1.id)
			end
		end

		describe ".update_project" do
			it "should be able to change the project name" do
				project = @db.update_project(@project1.id, "new_name")
				expect(project.name).to eq 'new_name'
				expect(project.name).to_not eq 'sxsw'
			end
		end

		describe ".update_task" do
			it "should be able to change the task name" do
				task = @db.update_task(@task1.id, priority: 3, description: "Set up instruments")
				task2 = @db.update_task(@task2.id, priority: 3)

				expect(task.priority).to eq(3)
				expect(task.priority).to_not eq(2)
				expect(task.description).to eq 'Set up instruments'
				expect(task.description).to_not eq 'Arrange bands'

				expect(task2.priority).to eq(3)
				expect(task2.priority).to_not eq(2)
				expect(task2.description).to eq 'Set up rails'
			end
		end

		describe ".update_employee" do
			it "should be able to change the employee name" do
				employee = @db.update_employee(@employee1.id, "Mallory")
				expect(employee.name).to eq('Mallory')
				expect(employee.name).to_not eq('Alice')
			end
		end

		describe ".delete_project" do
			it "should delete a project based on its id" do
				project_list = @db.all_projects

				expect(project_list.count).to eq(2)

				delete_project1 = @db.delete_project(@project1.id)
				delete_project2 = @db.delete_project(@project2.id)
				new_project_list = @db.all_projects

				expect(new_project_list.count).to eq(0)
			end
		end

		describe ".delete_task" do
			it "should delete a task based on its id" do
				task_list = @db.all_tasks

				expect(task_list.count).to eq(2)

				delete_task1 = @db.delete_task(@task1.id)
				delete_task2 = @db.delete_task(@task2.id)
				new_task_list = @db.all_tasks

				expect(new_task_list.count).to eq(0)
			end
		end

		describe ".delete_employee" do
			it "should delete a employee based on its id" do
				employee_list = @db.all_employees

				expect(employee_list.count).to eq(2)

				delete_employee1 = @db.delete_employee(@employee1.id)
				delete_employee2 = @db.delete_employee(@employee2.id)
				new_employee_list = @db.all_employees

				expect(new_employee_list.count).to eq(0)
			end
		end

		# describe ".get_emp_for_proj" do
		# 	it "should give a list of employees that belong to a project" do
		# 		empty_result = @db.get_emp_for_proj(@project1.id)

		# 		expect(empty_result).to eq([])

		# 		@db.recruit(@project1.id, @employee1.id)
		# 		@db.recruit(@project1.id, @employee2.id)
		# 		result = @db.get_emp_for_proj(@project1.id)
		# 		binding.pry
				
		# 		expect(result.count).to eq(2)
		# 	end
		# end

		describe '.get_emp_for_proj' do
	    it 'should give a list of employees for a specified project id' do
	    	@db.recruit(@project1.id, @employee1.id)
				@db.recruit(@project1.id, @employee2.id)
	      retrieved_employees = @db.get_emp_for_proj(@project1.id)

	      expect(retrieved_employees.count).to eq(2)
	      expect(retrieved_employees.first.id).to eq(@employee1.id)
	      expect(retrieved_employees.last.id).to eq(@employee2.id)
	    end
	  end

	  describe '.get_proj_for_emp' do
	    it 'should give a list of projects for a specified employee id' do
	      @db.recruit(@project1.id, @employee2.id)
				@db.recruit(@project2.id, @employee2.id)
	      retrieved_projects = @db.get_proj_for_emp(@employee2.id)

	      expect(retrieved_projects.count).to eq(2)
	      expect(retrieved_projects.first.id).to eq(@project1.id)
	      expect(retrieved_projects.last.id).to eq(@project2.id)
	    end
	  end
	end

	context "A Project with an employee" do
		before do
		  @project = @db.create_project('sxsw')
		  @employee = @db.create_employee('Alice')
		end

		describe ".emp_incomplete_tasks" do
			it "shows incomplete tasks given employee ID" do
				task_eat = @db.create_task(@project.id, 1, 'eat')
				task_sleep = @db.create_task(@project.id, 1, 'sleep')
				@db.assign_task_to_emp(task_eat.id, @employee.id)
				@db.assign_task_to_emp(task_sleep.id, @employee.id)
				incomplete_tasks = @db.emp_incomplete_tasks(@employee.id)

				expect(incomplete_tasks.count).to eq(2)
				expect(incomplete_tasks[0].id).to eq(task_eat.id)
				expect(incomplete_tasks[1].id).to eq(task_sleep.id)
			end
		end

		describe ".emp_complete_tasks" do
			it "shows completed tasks given employee ID" do
				task_eat = @db.create_task(@project.id, 1, 'eat')
				task_sleep = @db.create_task(@project.id, 1, 'sleep')
				task_shower = @db.create_task(@project.id, 3, 'shower')
				@db.assign_task_to_emp(task_eat.id, @employee.id)
				@db.assign_task_to_emp(task_sleep.id, @employee.id)
				@db.assign_task_to_emp(task_shower.id, @employee.id)
				completed_tasks = @db.emp_complete_tasks(@employee.id)

				expect(completed_tasks.first).to eq(nil)

				@db.mark_task_complete(task_eat.id)
				@db.mark_task_complete(task_shower.id)
				
				# Query database for completed tasks after marking them complete
				new_completed_tasks = @db.emp_complete_tasks(@employee.id)

				expect(new_completed_tasks.count).to eq(2)
				expect(new_completed_tasks.first.id).to eq(task_eat.id)
				expect(new_completed_tasks.last.id).to eq(task_shower.id)
			end
		end
	end
end