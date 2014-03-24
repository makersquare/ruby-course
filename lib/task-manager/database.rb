require 'singleton'

# made a singleton verion of ProjectList

class TM::DB
  include Singleton

  attr_reader :projects, :tasks

  # examples
  # proj_employees = @memberships.select do |memb|
  #   memb[:pid] == 1
  # end.map do |memb|
  #   @employees[memb[:eid]]
  # end

  # @employees = { 5 => Emp}
  # @memberships = [{ :eid => 5, :pid => 7 }, { :eid => 5, :pid => 9 }]

  def initialize
    @projects = {}
    @tasks = {}

    # @employees = {}
  end

  def create_project(title)
    proj = TM::Project.new(title)

    proj_id = proj.id
    @projects[proj_id] = proj

    proj
  end

  def add_task_to_proj(pid, desc, priority)

    # ensure id and priority are integers
    pid = pid.to_i
    priority = priority.to_i

    proj = @projects[pid]

    added_task = TM::Task.new(pid, desc, priority)
    @tasks[added_task.id] = added_task

    added_task

    # code prior to refactoring to hashes
    # added_task = proj.add_task(desc, priority)
  end

  def show_proj_tasks_remaining(pid)
    # ensure id is an integer
    pid = pid.to_i

    # binding.pry

    # array of tasks belonging to this pid
    # @tasks.values creates an array from values in @tasks hash
    pid_tasks = @tasks.values.select { |task| task.proj_id == pid }

    incomplete_tasks = pid_tasks.select do |task|
        task.completed == false
      end

    # code prior to refactoring
    # no longer listing tasks through projects
    # proj = @projects[pid]
    # proj.list_incomplete_tasks
  end

  def show_proj_tasks_complete(pid)
    # ensure id is an integer
    pid = pid.to_i

    pid_tasks = @tasks.values.select { |task| task.proj_id == pid }

    completed_tasks = pid_tasks.select { |task| task.completed == true }

    # code prior to refactoring to use Hashes
    # proj = @projects[pid]
    # proj.list_completed_tasks
  end


  def mark_task_as_complete(tid)
    # ensure id is an integer
    tid = tid.to_i

    @tasks[tid].completed = true

    @tasks[tid]

    # code prior to refactoring to use hash for @projects and @tasks
    # project = nil

    # @projects.each do |pid, proj|
    #   if proj.include_task?(tid)
    #     proj.mark_as_complete(tid)

    #     # set project variable to point to the project
    #     # that has the task we are looking for
    #     project = proj
    #   end
    # end

    # # return the task with id = tid
    # marked_task = project.tasks.find { |task| task.id == tid }
  end

end
