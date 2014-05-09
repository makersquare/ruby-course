class TM::Project
  attr_reader :name, :tasks, :pid, :projects
  attr_accessor :completion
  @@pid = 0
  @@projects = []

  def initialize(name)
    @name = name
    @pid = @@pid + 1
    @tasks = []
    @completion = 0.0

    # Increment class variable to keep ids unique
    @@pid = @pid
    # Add project to projects array
    @@projects << self
  end

  def completed_tasks
    completed_tasks = @tasks.select{ |task| task.status == 1 }
    completed_tasks.sort_by{ |task| task.created_at }
  end

  def incomplete_tasks
    # Find incomplete tasks, sorted by overdue? first, then by priority. In case of priority tie, sort by created at, oldest first
    incomplete_tasks = @tasks.select{ |task| task.status == 0 }
    incomplete_tasks = incomplete_tasks.sort_by{ |task| [ -task.overdue, -task.priority, task.created_at] }
  end

  def overdue_tasks
    @tasks.select{ |task| task.overdue? }
  end

  def project_completion_percent
    # Find overdue tasks, calculate percentage of project that is not overdue and return % rounded to two.
    overdue_tasks = self.overdue_tasks
    completion_percent = (1.0 - (overdue_tasks.length.to_f / @tasks.length)).round(2)
  end

  def tagged_tasks
    # Find tagged tasks to make searching easier
    @tasks.select{|task| task.tags != nil}
  end

  def search(tag)
    # Filter by tagged tasks and then select items with matching tags
    search_in = self.tagged_tasks
    search_in.select{|task| task.tags.include?(tag)}
  end

  def self.list_projects
    @@projects
  end

  def self.get_project(project_id)
    @@projects.detect{|project| project_id == project.pid}
  end

  # Used to reset class variables for rspec tests
  def self.reset_class_variables
    @@pid = 0
    @@projects = []
  end
end
