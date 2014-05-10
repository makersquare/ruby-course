
class TM::Task
  attr_reader :description, :priority, :project_id, :task_id, :created_at, :due_date, :recurring
  attr_accessor :status, :completed_at, :overdue
  @@task_id = 0
  @@tasks = []

  def initialize(project_id, desc, priority, due_date,opts={})
    @project_id = project_id
    @task_id = @@task_id + 1
    @description = desc
    @priority = priority
    @status = 0 # Initialize task as incomplete
    @created_at = Time.now
    @completed_at = nil
    @due_date = Date.parse(due_date)
    @overdue = 0
    @duplicated = false

    # Optional parameters
    @tags ||= opts[:tags]
    @recurring ||= opts[:recurring]

    # Increment task_id class variable
    @@task_id = @task_id
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

  def self.complete_task(task_id)
    task = @@tasks.detect{ |task| task_id == task.task_id }
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
