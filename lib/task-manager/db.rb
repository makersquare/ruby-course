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

    def create_task(data)
      task = Task.new(data)
      @all_tasks[task.id] = task
      return task
    end

    def get_task(task_id)
      return @all_tasks[task_id]
    end

    def completed_tasks(project_id)
      completed_tasks = @all_tasks.select { |k,v| (v.project_id == project_id) &&
                                                  (v.finished? == true)    }.values
      return completed_tasks.sort { |a,b| a.creation_date <=> b.creation_date }
    end

    def ongoing_tasks(project_id)
      ongoing_tasks = @all_tasks.select { |k,v| (v.project_id == project_id) &&
                                                 (v.finished? == false) }.values
      return ongoing_tasks.sort { |a,b| b.priority <=> a.priority }
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

        # if the project is not assigned, return nil, else assign it
        task = get_task(data[:task_id])
        if self.assigned?({ project_id: task.project_id, employee_id: data[:employee_id] })
          @tasks_employees << data
          return true
        else
          return false
        end   #endIf
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
  end



  def self.db
    @__db_instance ||= DB.new
  end
end
