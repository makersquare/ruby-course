
class TM::Project
  attr_accessor :id, :project_id, :tasks
  attr_reader :name


  @@project_id = 0

  def initialize(name)
    @name = name
    @@project_id += 1
    @project_id = @@project_id
    @tasks = Array.new(0)

  end

  def self.project_id
    @@project_id
  end


  def add_task(description, priority=3)
    @description = description
    @priority = priority
    @tasks << TM::Task.new(@project_id, description, priority)
  end

  def complete_task(task_id)
    selected = @tasks.select {|x| x.task_id == task_id}
    selected[0].status = 'complete'
  end

  def sort_by_date
    completed = @tasks.select {|x| x.status == 'complete'}
    completed.sort {|x ,y| x <=> y }
  end

  def incomplete_tasks
    incomplete = @tasks.select {|x| x.status == 'incomplete'}
    incomplete.sort {|x, y| x<=> y}
  end



end

