class TM::Middleman

  def self.create_task(project_id, description, priority)
    new_task = TM::Task.new(project_id, description, priority)
    return new_task
  end





end
