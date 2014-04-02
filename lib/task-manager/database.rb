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

		# ----- Data Models Create Methods -----
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

		# ----- Data Models Read Methods -----
		def project_incomplete_tasks(pid)
			@tasks.values.select { |task| task.project_id == pid && task.complete == false }.sort_by { |task| [task.priority, task.created_at] }
		end

		def project_complete_tasks(pid)
			@tasks.values.select { |task| task.project_id == pid && task.complete == true }.sort_by { |task| task.created_at }
		end

		def emp_incomplete_tasks(eid)
			@tasks.values.select { |task| task.employee_id == eid && task.complete == false }
		end

		def emp_complete_tasks(eid)
			@tasks.values.select { |task| task.employee_id == eid && task.complete == true }
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

		# ----- Data Models Update Methods -----
		def mark_task_complete(tid)
			task = @tasks[tid]
			task.complete = true
			task
		end

		def assign_task_to_emp(tid, eid)
			task = @tasks[tid]
			task.employee_id = eid
			task
		end

		def update_project(pid, name)
			project = @projects[pid]
			project.name = name
			project
		end

		def update_task(tid, options={})
			task = @tasks[tid]
			if options[:description]
				task.description = options[:description]
			end
			if
				task.priority = options[:priority]
			end
			task
		end

		def update_employee(eid, name)
			employee = @employees[eid]
			employee.name = name
			employee
		end

		# ----- Data Models Delete Methods -----
		def delete_project(pid)
			@projects.delete(pid)
			@projects
		end

		def delete_task(tid)
			@tasks.delete(tid)
			@tasks
		end

		def delete_employee(eid)
			@employees.delete(eid)
			@employees
		end

		# ----- Membership Methods -----
		def recruit(pid, eid)
			membership = {:pid => pid, :eid => eid}
			@memberships << membership
			membership
		end

		def get_emp_for_proj(pid)
			proj_with_pid = @memberships.select { |memb| memb[:pid] == pid }
			emps_for_proj =  proj_with_pid.map { |memb| @employees[memb[:eid]] }

			emps_for_proj.each do |emp|
				puts emp.name
			end
		end
    #   project_employees = []
    #   @memberships.each do |membership|
    #     membership.select do |key, value|
    #       if key == pid
    #         project_employees << value
    #       end
    #     end
    #   end
    #   project_employees
    # end

		def get_proj_for_emp(eid)
			emp_with_eid = @memberships.select { |memb| memb[:eid] == eid }
			proj_for_emp =  emp_with_eid.map { |memb| @projects[memb[:pid]] }

			proj_for_emp.each do |proj|
				puts proj.name
			end
			# employee_projects = []
			# @memberships.each do |membership|
			# 	membership.select do |key, value|
			# 		if value == eid
			# 			employee_projects << key
   #        end
			# 	end
			# end
			# employee_projects
		end
	end
end
