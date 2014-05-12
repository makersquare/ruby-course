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
    # { id: {name: "project1, id: 1"}}
    @project_count = 0
    @tasks = {}
    @task_count = 0
  end

  ## universal methods

  def get_timestamp
    Time.now
  end

  ##########
  # Projects
  ##########

  def build_project(data)
    # TM::Project.new(name: data[:name], id: data[:id])
    TM::Project.new(data)
  end

  def create_project(data)
    ## should i validate the 'data' argument?
    ## what if already a project with same id?...reject!
    @project_count +=1
    data[:id] ||= @project_count
    @projects[data[:id]] = data
    build_project(data)
  end

  def get_project(id)
    project = @projects.select { |key, value| key == id }
    build_project(project[id]) unless project.size == 0
  end

  def destroy_project(id)
    project = @projects.select { |key, value| key == id }
    build_project(@projects.delete(id)) unless project.size == 0
  end

  #######
  # Tasks
  #######

  def build_task(data)
    #name, id, description, priority, date_created, due_date, date_completed
    # completed, project_id --> independent variables/properties
    TM::Task.new(data)
  end

  def create_task(data)
    ## should i validate the 'data' argument?
    ## what if already a project with same id?...reject!
    # how to hanlde the auto-genarated timestamp?
    @task_count +=1
    data[:id] ||= @task_count
    @tasks[data[:id]] = data
    build_task(data)
  end

  def get_task(id)
    task = @tasks.select { |key, value| key == id }
    build_task(task[id]) unless task.size == 0
  end

  def destroy_task(id)
    task = @tasks.select { |key, value| key == id }
    build_task(@tasks.delete(id)) unless task.size == 0
  end

end