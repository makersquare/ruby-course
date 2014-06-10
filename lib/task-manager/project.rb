#require 'task'
require 'pry-debugger'

class TM::Project
  attr_reader :name, :id

  @@counter = 0
  @@project_list = []

  def initialize(name)
    @name = name
    @@counter += 1
    @id = @@counter
    @@project_list << self
  end

  def add_task(desc, priority)
    TM::Task.new(@id,desc,priority)
  end

  def get_complete_tasks
    project_tasks = TM::Task.task_list.values.select { |t| t.project == @id && t.complete == true }
    project_tasks.sort_by { |t| t.created }
  end

  def get_incomplete_tasks
    project_tasks = TM::Task.task_list.values.select { |t| t.project == @id && t.complete == false }
    project_tasks.sort_by { |t| [(t.priority * -1), t.created] }

  end

end
