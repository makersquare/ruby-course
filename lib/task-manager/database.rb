# require 'pry-debugger'

module TM
  def self.db
    @__db_instance ||= DB.new
  end
end

class TM::DB

  attr_reader :tasks, :projects, :project_count

  def initialize
    @projects = {}
    # { id: {name: "project1, id: 1"}}
    @project_count = 0
    @tasks = {}
    @task_count = 0
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
    build_project(project[id])
  end

  def destroy_project(id)
    project = @projects.select { |key, value| key == id }
    @projects.delete(id)
  end

  def build_project(data)
    TM::Project.new(data[:name], data[:id])
  end

end