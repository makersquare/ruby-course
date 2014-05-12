
class TM::Task
  attr_accessor :description, :priority, :project_id, :task_id, :created_at,
                :due_date, :recurring, :status, :completed_at, :overdue
  @@task_id = 0

  def initialize(params)
    @project_id = params[:project_id]
    @task_id = params[:task_id]
    @description = params[:desc]
    @priority = params[:priority]
    @status = 0 # Initialize task as incomplete
    @created_at = Time.now
    @completed_at = nil
    @due_date = Date.parse(params[:due_date])
    @overdue = 0
    @duplicated = false

    # Optional parameters
    @tags ||= params[:tags]
    @recurring ||= params[:recurring]
  end

  def tags
    @tags
  end

  def overdue?
    true if @due_date < Date.today
  end

  def frequency
    if @recurring == 1
      'daily'
    elsif @recurring == 2
      'weekly'
    else
      'one time'
    end
  end

  def duplicated?
    true if @duplicated == true
  end

  def duplicated=(duplicated)
    @duplicated = true
  end

  def complete_task(task_id)
    task = TM.database.show_task(task_id)
    task.completed_at = Time.now
    task.status = 1
  end

  def self.mark_overdue
    # Do this in a class method so all tasks can be updated as overdue at once. Not ideal.
    @@tasks.each do |task|
      task.overdue = 1 if task.overdue?
    end
  end

  # Reset class variables for rspec tests
  def self.reset_class_variables
    @@task_id = 0
    @@tasks = []
  end

  def self.repeat_tasks
    # Find daily tasks
    daily = @@tasks.select{|task| task.recurring == 1}

    # Find weekly tasks
    weekly = @@tasks.select{|task| task.recurring == 2}
    daily.each do |task|
      if task.created_at + (24*60*60) < Time.now && !task.duplicated?
        pid = task.project_id
        desc = task.description
        priority = task.priority
        due_date = task.due_date.to_s
        tags = task.tags
        recurring = task.recurring
        self.new(pid,desc,priority,due_date,tags: tags, recurring: recurring)
        task.duplicated = true
      end
    end

    weekly.each do |task|
      if task.created_at + (144*60*60) < Time.now && !task.duplicated?
        pid = task.project_id
        desc = task.description
        priority = task.priority
        due_date = task.due_date.to_s
        tags = task.tags
        recurring = task.recurring
        self.new(pid,desc,priority,due_date,tags: tags, recurring: recurring)
        task.duplicated = true
      end
    end
  end
end
