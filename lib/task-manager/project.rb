class TM::Project

  @@counter = 0

  attr_reader :project_name, :id
  attr_accessor :tasks

  def self.generate_id
    @@counter +=1
    @@counter
  end

  def initialize(project_name)
    @project_name = project_name
    @id = TM::Project.generate_id
    @tasks = []

  end

  def add_task(task)
    task.project_id = @id
    @tasks.push(task)
  end

  def mark_task_complete(task_id)
    completed_task = @tasks.find{|task| task.id == task_id}
    completed_task.complete = true
  end

  def retrieve_completed_tasks
    completed_tasks = @tasks.select{|task| task.complete == true}
    completed_tasks.sort! {|x,y| x.creation_date <=> y.creation_date }

    completed_tasks
  end

  def retrieve_incomplete_tasks
    incomplete_tasks = @tasks.select{|task| task.complete == false}
    incomplete_tasks.sort! {|x,y| x.priority <=> y.priority}

    incomplete_tasks
  end

end
