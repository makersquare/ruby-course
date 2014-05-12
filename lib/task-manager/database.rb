# require 'pry-debugger'

module TM
  def self.db
    @__db_instance ||= DB.new
  end
end

class TM::DB

  attr_reader :projects, :project_count, :tasks, :task_count

  def initialize
    @projects = {}
    @project_count = 0
    @tasks = {}
    @task_count = 0
  end

  ##########
  # Projects
  ##########

  def build_project(data)
    TM::Project.new(data)
  end

  def create_project(data)
    @project_count +=1
    data[:id] ||= @project_count
    if @projects[data[:id]]
      @project_count -=1
      return nil
    else
      @projects[data[:id]] = data
      build_project(data)
    end
  end

  def get_project(id)
    project = @projects.select { |key, value| key == id }
    build_project(project[id]) unless project.size == 0
  end

  def destroy_project(id)
    project = @projects.select { |key, value| key == id }
    build_project(@projects.delete(id)) unless project.size == 0
  end

  #################
  # Project Queries
  #################

  def get_all_projects
    all = []
    @projects.each {|id, data| all << build_project(data)}
    all
  end

  #######
  # Tasks
  #######

  def build_task(data)
    TM::Task.new(data)
  end

  def create_task(data)
    @task_count +=1
    data[:id] ||= @task_count
    if @tasks[data[:id]]
      @task_count -=1
      return nil
    else
      @tasks[data[:id]] = data
      build_task(data)
    end
  end

  def get_task(id)
    task = @tasks.select { |key, value| key == id }
    build_task(task[id]) unless task.size == 0
  end

  def update_task(id, data)
    # Need to add check if the task exists or not
    # task = @tasks.select { |key, value| key == id }
    @tasks[id].merge!(data) if @tasks.has_key?(id)
    # if @tasks.select { |key, value| key == id }
    # data.each {|key, val| @tasks[id][key] = val}
    build_task(@tasks[id]) # unless task.size == 0
    # puts @tasks.inspect
  end

  def destroy_task(id)
    task = @tasks.select { |key, value| key == id }
    build_task(@tasks.delete(id)) unless task.size == 0
  end

  ##############
  # Task Queries
  ##############

  def get_all_tasks
    all = []
    @tasks.each {|id, data| all << build_task(data)}
    all
  end

  def get_tasks_from_project(project_id)
    all = []
    @tasks.each do |id, data|
      all << build_task(data) if data[:project_id] == project_id
    end
    all
  end

  ###############
  # Print methods
  ###############



end