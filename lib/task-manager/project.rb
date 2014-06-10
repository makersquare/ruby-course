
class TM::Project

  @@id_hello = 0

  attr_reader :name
  attr_accessor :id

  def initialize(name)
    @name = name
    @id = @@id_hello +=1
  end


  def sort_tasks_priority
  end

  def sort_tasks_date
  end

  def complete_tasks
  end

  def incomplete_tasks
  end
end
