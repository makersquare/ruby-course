class TM::Project

  attr_reader :name, :id
  # attr_accessor :task

  def initialize(name, id, completed)
    @name = name
    @id = id
    @completed = false
  end

  def complete_project
    @completed = true
  end

  def completed?
    @completed
  end

  # def completed_task
  #   completed = @task.select do |task_item|
  #     task_item.completed
  #   end
  #   sort_by_date_completed(completed)
  # end


  # def sort_by_date_completed(task)
  #   task.sort_by { |item| item.date_created }
  # end

  # def incomplete_task
  #   @task.select do |task_item|
  #     task_item.completed == false
  #   end
  # end

  # def overdue_sort(incomplete)
  #   over_due = []
  #   incompleted = []
  #   incomplete.each do |task|
  #     if task.over_due?
  #       over_due << task
  #     else
  #       incompleted << task
  #     end
  #   end
  #   over_due + incompleted
  # end

  # def incompleted_task
  #   incomplete = incomplete_task.sort_by! { |task| [task.priority, task.task_id] }
  #   overdue_sort(incomplete)
  # end

  # def add_task(project_id, priority, description)
  #   task = TM::Task.new(project_id, priority, description)
  #   @task << task
  # end

  # def self.reset_class_variables
  #   @@unique_id = 0
  # end

end
