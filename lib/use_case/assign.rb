module TM
  class Assign < UseCase
    def run(data)
      case

      # project and employee have been passed
      when ((data[:project_id] != nil) && (data[:employee_id] != nil))
        if TM::db.get_project(data[:project_id]) == nil
          return failure(:project_not_found)
        elsif TM::db.get_employee(data[:employee_id]) == nil
          return failure(:employee_not_found)
        else
          TM::db.assign(data)
          return success
        end

      when ((data[:employee_id] != nil) && data[:task_id] != nil)
        employee = TM::db.get_employee(data[:employee_id])
        task = TM::db.get_task(data[:task_id])
        if task == nil
          return failure(:task_not_found)
        elsif employee == nil
          return failure(:employee_not_found)
        elsif TM::db.assigned?({ employee_id: employee.id, project_id: task.project_id }) == false
          return failure(:employee_not_assigned_to_project)
        else
          TM::db.assign({employee_id: employee.id, task_id: task.id })
          return success
        end
      end   #endCase
    end
  end
end
