
class TM::Task

  attr_accessor :project_id, :description, :priority_number, :task_complete, :creation_date, :tid

  @@tid_count = 0
  @@tasks = []

  def initialize(project_id, description, priority_number)

    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @task_complete = false
    @creation_date = Time.now
    @@tid_count +=1
    @tid = @@tid_count
    @creation_date = Time.now
  end

  def complete_task?
    @task_complete == true
  end

  def self.mark_complete(tid)
    t = @@tasks.select {|x| x.id == tid}.first
    t.task_complete = true
  end

  def self.reset_class_variables
    @@tid_count = 0
    @@tasks = []
  end

  def view
    if @complete_task == true
      status = "complete"
    else
      status = "incomplete"
    end
    "#{@id} : #{status} : #{description}"
  end
end
