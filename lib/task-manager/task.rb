class TM::Task

  attr_accessor :name, :status, :creation_date, :description, :task_id
  attr_reader :priority_number, :project_id

  @@class_task_id = 0
  def initialize(name, priority_number,description=nil, project_id)
    @name = name
    @status = "incomplete"
    @creation_date = Time.now
    @priority_number = priority_number #remove @ and change to p_number?
    @description = description
    @task_id = @@class_task_id += 1
    @project_id = project_id
  end

  def priority_number=(number)
    if number > 5
      priority_number = 5
    elsif number < 0
      priority_number = 0
    else
      priority_number = number
    end
  end

end
