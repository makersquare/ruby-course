module TM
  class DB

    def initialize
      @all_projects = {}
      @all_tasks = {}
      @all_employees = {}
      @projects_employees = []
      @tasks_employees = []
    end

    def create_project(name)
      project = Project.new(name)
      @all_projects[project.id] = project
      return project
    end

    def get_project(project_id)
      return @all_projects[project_id]
    end

    def list_projects
      return @all_projects.sort_by { |k,v| v.id }
    end


    def create_task(data)
      task = Task.new(data)
      @all_tasks[task.id] = task
      return task
    end

    def get_task(task_id)
      return @all_tasks[task_id]
    end

    def completed_tasks(data)
      case
      when data[:project_id] != nil
        completed_tasks = @all_tasks.select { |k,v| (v.project_id == data[:project_id]) &&
                                                    (v.finished? == true)    }.values
        return completed_tasks.sort { |a,b| a.creation_date <=> b.creation_date }
      when data[:employee_id] != nil
        completed_tasks = @all_tasks.select { |k,v| (self.assigned?({ employee_id: data[:employee_id], task_id: v.id })) &&
                                              (v.finished? == true)    }.values
        return completed_tasks.sort { |a,b| a.creation_date <=> b.creation_date }
      end
    end

    def ongoing_tasks(data)
      if data[:project_id] != nil
        ongoing_tasks = @all_tasks.select { |k,v| (v.project_id == data[:project_id]) &&
                                                 (v.finished? == false) }.values
        return ongoing_tasks.sort { |a,b| b.priority <=> a.priority }
      elsif data[:employee_id] != nil
        ongoing_tasks = @all_tasks.select { |k,v| (TM::db.assigned?({ employee_id: data[:employee_id], task_id: v.id })) &&
                                                 (v.finished? == false) }.values
        return ongoing_tasks.sort { |a,b| b.priority <=> a.priority }
      end
    end

    def create_employee(name)
      employee = Employee.new(name)
      @all_employees[employee.id] = employee
      return employee
    end

    def get_employee(employee_id)
      return @all_employees[employee_id]
    end

    def assign(data)
      case
      # employee_id and project_id
      when (data[:employee_id] != nil) && (data[:project_id] != nil)
        @projects_employees << data
        return true

      # employee_id and task_id
      when (data[:employee_id] != nil) && (data[:task_id] != nil)
        @tasks_employees << data
      end   #endCase
    end    #end def

    def assigned?(data)
      case
      # employee_id & project_id have been passed
      when (data[:employee_id] != nil) && (data[:project_id] != nil)
        @projects_employees.include?(data) ? (return true) : (return false)

      # employee_id & task_id have been passed
      when (data[:employee_id] != nil) && (data[:task_id] != nil)
        @tasks_employees.include?(data) ? (return true) : (return false)
      end
    end

    def get_assigned_tasks(employee_id)
        return @all_tasks.select { |k,v| self.assigned?({ employee_id: employee_id, task_id: v.id }) }.values
    end

    def get_assigned_employees(data)
      if data[:project_id] != nil
        return @all_employees.select { |k,v| self.assigned?({ employee_id: v.id, project_id: data[:project_id] }) }.values
      elsif data[:task_id] != nil
        return @all_employees.select { |k,v| self.assigned?({ task_id: data[:task_id], employee_id: v.id }) }.values
      end
    end

    def employees_list
      return @all_employees.values.sort_by { |v| v.id }
    end

  end

  def self.db
    @__db_instance ||= DB.new
  end
end
