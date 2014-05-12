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
    build_project(@projects[id]) if @projects.has_key?(id)
  end

  def destroy_project(id)
    build_project(@projects.delete(id)) if @projects.has_key?(id)
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
    build_task(@tasks[id]) if @tasks.has_key?(id)
  end

  def update_task(id, data)
    if @tasks.has_key?(id)
      @tasks[id].merge!(data)
      build_task(@tasks[id])
    else
      nil
    end
  end

  def destroy_task(id)
    build_task(@tasks.delete(id)) if @tasks.has_key?(id)
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

  def get_completed_tasks_from_project(project_id)
    all = get_tasks_from_project(project_id)
    all.select {|task| task.completed }
  end

  def get_remaining_tasks_from_project(project_id)
    all = get_tasks_from_project(project_id)
    all.select {|task| !task.completed }
  end

  ###############
  # Print methods
  ###############



end