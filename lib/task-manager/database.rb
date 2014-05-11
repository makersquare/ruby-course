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
    # { id: {data}}
    @project_count = 0
  end

  def create_project(data)
    ## use the actual "data" argument to contsruct!!
    ## should i validate the 'data' argument?
    ## what if already a project with same id?...reject!()
    @project_count +=1
    @projects[data[:id]] = data
    # @projects[@project_count] = data
    # @projects[@project_count][:id] = @project_count
    build_project(data)
  end

  def get_project(id)
    ## use select
    # project_key = nil
    project = @projects.select { |key, value| key == id }
    # @projects.each do |key, data|
    #   project_key = key if data[:id] == id
    # end
    # build_project(@projects[project_key])
    # puts "Project --> #{project}"
    # puts "Project --> #{project[id]}"
    build_project(project[id])
  end

  def destroy_project(id)
    project = @projects.select { |key, value| key == id }
    # project_key = nil
    # @projects.each do |key, data|
    #   project_key = key if data[:id] == id
    # end
    # @projects.delete(project_key)
    @projects.delete(id)
  end

  def build_project(data)
    # binding.pry
    # puts "data --> #{data}"
    TM::Project.new(data[:name], data[:id])
    # TM::Project.new(data[:name])
  end

end