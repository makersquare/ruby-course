class TM::Middleman

  def self.create_task(project_id, description, priority)
    new_task = TM::Task.new(project_id, description, priority)
    return new_task
  end

  def self.mark_task(task_id)
    TM::DB.instance.all_tasks[task_id].finished = true
  end

  def self.assign_task_to_employee(task_id, employee_id)
    TM::DB.instance.all_employees[employee_id].tasks[task_id] = TM::DB.instance.all_tasks[task_id]
  end

  def self.create_employee(name)
    TM::Employee.new(name)
  end

end
