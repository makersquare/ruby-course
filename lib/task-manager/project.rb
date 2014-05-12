require 'date'
class TM::Project
  attr_reader :id
  attr_accessor :name, :tasks, :completed_task, :incomplete_task, :projects, :percentage

  # @@class_id = 1
  # @@projects =[]

  def initialize(name, id)
    @name = name
    @id = id
    @tasks = []
    # @@projects<<self
    @percentage = 0
  end

  # def self.projects
  #   @@projects
  # end

  def create_task(project_id, description, priority_number, due_date)
    x = TM::Task.new(project_id, description, priority_number, due_date)
    @tasks<<x
  end

  def percentage_complete
    @percentage = @completed_task.length/@tasks.length
  end

  def mark_complete(project_id)
    for i in 0...@tasks.length
      if @tasks[i].project_id == project_id
        if @tasks[i].status == "incomplete"
            @tasks[i].status = "complete"
            return @tasks[i].status
        else
          puts "The task is already complete."
        end
      end
    end
  end

  def completed_tasks()
    @completed_task = []
    for i in 0...@tasks.length
      if @tasks[i].status == "complete"
        @completed_task<<@tasks[i]
      end
    end
    @completed_task.sort_by! {|x| x.creation_date}
  end

  def incomplete_tasks()
    @incomplete_task = []
    for i in 0...@tasks.length
      if @tasks[i].status == "incomplete"
        @incomplete_task<<@tasks[i]
      end
      if @tasks[i].due_date < Date.today
        @tasks[i].overdue = "overdue"
      end
    end
    @incomplete_task.sort_by! {|x| [x.priority_number, x.overdue]}
  end

  # def self.reset_class_variables
  #     @@projects = []
  # end

end
