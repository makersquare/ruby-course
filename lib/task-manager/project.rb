
class TM::Project
  attr_reader :name, :id, :tasks, :projectlist, :employees_on_project

  @@projectcount = 0

  def initialize(name)
    @name = name
    @id = TM::Project.gen_id
    @@projectcount += 1
    @tasks = {}
    @employees_on_project = []
  end

  def self.gen_id
    @@projectcount
  end

  def addtask(project_id, description, priority)
    @tasks[project_id] = TM::Task.new(project_id, description, priority)
  end

  def markcomplete(project_id)
    @tasks[project_id].complete = true
  end

  def completedlist
    completedarray = @tasks.select { |project_id, task| task.complete }.values
    completedarray.sort_by! { |task| task.timecreated }
  end

  def incompletelist
    incompletedhash = @tasks.select { |project_id, task| !task.complete }
    incompletedarray = []
    incompletedhash.each { |project_id, task| incompletedarray.push(task) }
    incompletedarray.sort_by! { |task| [task.priority, task.timecreated] }
  end

  def addemployee(employee)
    @employees_on_project.push(employee)
  end

  def assigntask(task,employee)
    employee.taketask(task) if @employees_on_project.include?(employee)
  end
end
