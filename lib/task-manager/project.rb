
class TM::Project
  attr_reader :id, :name

  def initialize(args)
    @id   = args[:id]
    @name = args[:name]
  end

  # def new_task(priority, description)
  #   TM::Task.new(id, priority, description)
  # end

  # def incompleted_tasks
  #   TM::Task.tasks_for(id)
  # end

  # def completed_tasks
  #   TM::Task.tasks_for(id, completed = true)
  # end

  # def create
  #   args = TM.db.create_project( [ @name, @completed ] )
  #   @id         = args[:id]
  #   @created_at = args[:created_at]
  #   self
  # end

end
