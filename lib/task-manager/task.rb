
class TM::Task
  @@counter = 1
  @@tasks = []
  attr_reader :description, :project_id, :priority, :task_id, :creation_date, :options
  attr_accessor :status, :date_completed

  def initialize(description, project_id, priority, opts={})
    @description = description
    @project_id = project_id
    @priority = priority
    @task_id = @@counter
    @status = "Not completed"
    @date_completed = nil
    @creation_date = Date.today
    @@counter += 1
    @options = {:due_date => Date.today}
    @options.merge!(opts)
    @@tasks << self
  end

  def self.tasks
    @@tasks
  end

  def self.reset_class_variables
    @@counter = 1
    @@tasks = []
  end

  def self.mark_complete(task_id)
    @@tasks.each do |task|
      if task.task_id == task_id
        task.status = "Completed"
        task.date_completed = Date.today.to_s
      end
    end
  end

  def add_tags(tag_array)
    if @options.has_key?(:tags)
      temp_tags = @options[:tags]
      @options[:tags] = temp_tags + tag_array
    else
      @options[:tags] = tag_array
    end
  end

  def due_date=(date)
    @options[:due_date] = Date.parse(date)
  end
end
