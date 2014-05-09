
class TM::Project
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end

  def complete_tasks
    TM::Task.retrieve_tasks(@id, true)
  end

  def incomplete_tasks
    TM::Task.retrieve_tasks(@id, false)
  end
end
