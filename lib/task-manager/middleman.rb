class TM::Middleman

  def self.create_task(project_id, description, priority)
    new_task = TM::Task.new(project_id, description, priority)
    return new_task
  end

  def self.mark_task(task_id)
    TM::DB.instance.all_tasks[task_id].finished = true
  end

  def self.get_assigned_employees(project_id)
    return TM::DB.instance.all_employees.select { |k, v| v.projects.has_key?(project_id) }.values
  end



end
