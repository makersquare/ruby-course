
class TM::Project
  attr_reader :name, :project_id, :tasks, :projectlist, :employees_on_project

  @@projectcount = 0

  def initialize(name)
    @name = name
    @project_id = TM::Project.gen_id
    @@projectcount += 1
    @tasks = {}
    @employees_on_project = []
  end

  def self.gen_id
    @@projectcount
  end

  def addtask(description, priority)
    temp_task = TM::Task.new(description, priority, @project_id)
    @tasks[temp_task.task_id] = temp_task
  end

  def markcomplete(task_id)
    @tasks[task_id].complete = true
  end

  def completedlist
    completedarray = @tasks.select { |task_id, task| task.complete }.values
    completedarray.sort_by! { |task| task.timecreated }
  end

  def incompletelist
    incompletedhash = @tasks.select { |task_id, task| !task.complete }
    incompletedarray = []
    incompletedhash.each { |task_id, task| incompletedarray.push(task) }
    incompletedarray.sort_by! { |task| [task.priority, task.timecreated] }
  end

  def addemployee(employee)
    @employees_on_project.push(employee)
  end

  def assigntask(task,employee)
    employee.taketask(task) if @employees_on_project.include?(employee)
  end
end
