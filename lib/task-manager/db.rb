require 'pry-debugger'

class TM::DB
  attr_reader :projects, :project_count, :tasks, :task_count

  def initialize
    @projects = {}
    @tasks = {}
    @project_count = 0
    @task_count = 0
  end

  # Project management

  def build_project(data)
    TM::Project.new(data[:name], data[:id])
  end

  def update_project(id, data)
    # Find a project by id in the @project hash and update
    # Data is a hash of k,v pairs with :name => "name", etc
    project = @projects.select{|key,value| key == id}
    data.each do |key,value|
      project[id][key] = value
    end
    build_project(project[id])
  end

  def destroy_project(id)
    # Find a project by id in the @project hash and remove
    project = @projects.select{|key,value| key == id}
    @projects.delete(id)

    # Return the deleted object in case we need it
    build_project(project[id])
  end

  def show_project(id)
    # Find project by id in @project hash
    project = @projects.select{|key,value| key == id}
    build_project(project[id])
  end

  def create_project(data)
    # Insert project into database
    @projects[data[:id]] = data
    # Increment project counter
    @project_count += 1
    build_project(data)
  end

  # Task management

  def build_task(data)
    TM::Task.new(data[:project_id], data[:desc], data[:priority], data[:due_date])
  end

  def create_task(data)
    @tasks[task_count] = data
    build_task(data)
    @task_count += 1
  end

  def show_task(id)
    task = @tasks.select{|key,value| key == id}
    build_task(task[id])
  end
end
