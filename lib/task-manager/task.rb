class TM::Task

  attr_accessor :name, :creation_date, :description, :task_id
  attr_reader :priority_number, :project_id, :status

  @@class_task_id = 0
  @@task_list = {}

  def initialize(name, p_number,description=nil, project_id)
    @name = name
    @status = "incomplete"
    @creation_date = Time.now
    self.priority_number = p_number #remove @ and change to p_number?
    @description = description
    @task_id = @@class_task_id += 1
    @project_id = project_id
    @@task_list[@task_id] = self
  end

  def priority_number=(number)
    if number > 5
      @priority_number = 5
    elsif number < 0
      @priority_number = 0
    else
      @priority_number = number
    end
  end

  def mark_complete
    if @status == "incomplete"
      @status = "complete"
    end
  end
end
