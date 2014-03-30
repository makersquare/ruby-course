module TM

  # Our singleton getter
  def self.db
    @__db_instance ||= Database.new
  end

  # Our singleton class
  class Database
    attr_accessor :projects, :tasks, :employees, :memberships

    def initialize
      @projects = {
        # id => proj obj
      }

      @tasks = {
        # id => task obj
      }

      @employees = {
        #id => emp obj
      }

      @memberships = [
        #{ :eid => #, :pid => # }
        #{ eid => pid }
        #{ eid => pid }
        #{ eid => pid }
      ]
    end

    def create_project(name)
      newproject = TM::Project.new(name)
      @projects[newproject.pid] = newproject
    end

    def create_task(description, project_id, priority)
      project_id = project_id.to_i
      priority = priority.to_i
      task = TM::Task.new(description, project_id, priority)
      @tasks[task.tid] = task
      task
    end

    def get_task(tid)
      @tasks[tid]
    end

    def delete_task(id)
      @tasks.delete(id)
      @tasks
    end

    def task_completed(task_id)
      task = @tasks.values.find { |task| task.tid == task_id }
      task.status = true
      task
    end

    def retrieve_completed
      tasks_complete = @tasks.values.select { |task| task.status == true }
      tasks_complete.sort_by!{|task| task.tid}
    end

    def retrieve_incomplete
      tasks_incomplete = @tasks.values.select { |task| task.status == false }
      tasks_incomplete.sort_by! {|task| [task.priority_number, task.tid]}
    end

    def new_employee(name)
      employee = TM::Employee.new(name)
      @employees[employee.eid] = employee
      employee
    end

    def assign_task_to_emp(eid, tid)
      task = @tasks.values.find { |task| task.tid == tid }
      task.employee_id = eid

      membership = Hash[eid => task.project_id]
      @memberships.push(membership)

      task
    end

    # def create_membership(eid, pid)
    #   membership = Hash[eid => pid]
    #   @memberships.push(membership)
    # end

  end

end
