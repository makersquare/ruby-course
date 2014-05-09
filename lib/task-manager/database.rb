class TM::DB

  attr_reader :tasks, :projects

  def initialize
    @projects = {}
    # { id: {data}}
    @project_count = 0
  end

  def create_project(data)
    @project_count +=1
    @projects[@project_count] = data
    @projects[@project_count][:id] = @project_count
    return build_project(@projects[@project_count])
  end

  def get_project(id)
    project_key = nil
    @projects.each do |key, data|
      project_key = key if data[id] == id
    end
    return build_project(@projects[project_key])
  end

  def destroy_project(id)
    project_key = nil
    @projects.each do |key, data|
      project_key = key if data[id] == id
    end
    @projects[project_count].delete
  end

  def build_project(data)
    TM::Project.new(data[:name], data[:id])
    # TM::Project.new(data[:name])
  end

  def self.db
    @__db_instance ||= DB.new
  end

end