module TM

	def self.db
		@__db_instance ||= Database.new
	end

	class Database
		attr_reader :projects, :tasks, :employees, :memberships

		def initialize
			@projects = {}
			@tasks = {}
			@employees = {}
			@memberships = []
		end

		def create_project(name)
			project = TM::Project.new(name)
			@projects[project.id] = project
			project
		end

		def create_employee(name)
			employee = TM::Employee.new(name)
			@employees[employee.id] = employee
			employee
		end

		def create_task(pid, priority, description)
			task = TM::Task.new(pid, priority, description)
			@tasks[task.id] = task
			task
		end

		def recruit(pid, eid)
			membership = {project_id: pid, employee_id: eid}
			@memberships << membership
			membership
		end

		def mark_task_complete(tid)
			task = @tasks[tid]
			task.complete = true
		end

		def project_incomplete(pid)
			@tasks.values.select { |task| task.project_id == pid && task.complete == false }.sort_by { |task| [task.priority, task.created_at] }
		end

		def project_complete(pid)
			@tasks.values.select { |task| task.project_id == pid && task.complete == true }.sort_by { |task| task.created_at }
		end

		def all_projects
			@projects.values
		end

		def all_tasks
			@tasks.values
		end

		def all_employees
			@employees.values
		end

		def get_project(pid)
			@projects[pid]
		end

		def get_employee(eid)
			@employees[eid]
		end

		def get_task(tid)
			@tasks[tid]
		end
	end
end
