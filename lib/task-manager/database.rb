class TM::Project

  attr_reader :tasks, :projects
  def initialize
    @projects = {}
      # { id: {data}}
      @project_count = 0
    end

    def create_project(data)
      @project_count +=1
      @projects[@project_count] = data
      return build_project(data)
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
      Project.new(data[:name], data[:id])
    end

  end

  def self.db
    @__db_instance ||= DB.new
  end
end