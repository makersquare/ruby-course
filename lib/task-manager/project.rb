
class TM::Project

  attr_reader :name

  @@id = 0

  def initialize(name)
    @name = name
    #either declare ID as class var or make random
    @@id +=1
    @all_tasks = []
    @comp_tasks = []
    @inc_tasks = []
  end

  def add_task(new_task)
    @all_tasks << new_task
    @inc_tasks << new_task
  end

end


