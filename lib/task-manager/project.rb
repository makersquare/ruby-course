
class TM::Project

  attr_reader :name, :id
  def initialize(name)
    @name = name
    @@id = (0...8).map {(65+rand(26)).chr}.join
    @comp_tasks_array = []
  end

  def self.id
    @@id
  end

  def completed_tasks_method(task)
      if task.task_completion[1] == "yes"
        @comp_tasks_array << task.task_completion
      end
    @comp_tasks_array.sort {|x| x[2]}
  end
end
