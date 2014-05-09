
class TM::Project
  attr_reader :name, :id

  @@id_count = 0

  def initialize(name)
    @name = name
    @@id_count += 1
    @id = @@id_count
  end

  def self.reset_class_variables
    @@id_count = 0
  end

  def complete_tasks
    TM::Task.retrieve_tasks(@id, true)
  end

  def incomplete_tasks
    TM::Task.retrieve_tasks(@id, false)
  end
end
