class TM::Project

  attr_reader :name, :id
  # attr_accessor :task

  def initialize(name, id, completed)
    @name = name
    @id = id
    @completed = completed
  end

  def complete_project
    TM.db.update_project(@id, { completed: true })
  end

  def completed?
    @completed
  end

  def incomplete_task
    hold_task = []
    TM.db.task.each do |key, value|
      if value[:pid] == @id && value[:completed] == false
        hold_task << value
      end
    end
    hold_task.sort_by { |task| [task[:priority], task[:id]]}
  end

  def completed_task
    hold_task = []
    TM.db.task.each do |key, value|
      if value[:pid] == @id && value[:completed] == true
        hold_task << value
      end
    end
    hold_task.sort_by { |task| [task[:priority], task[:id]]}
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
