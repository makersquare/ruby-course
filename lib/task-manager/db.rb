module TM
  class DB

    def initialize
      @all_projects = {}
    end



    def create_project(name)
      project = Project.new(name)
      @all_projects[project.id] = project
      return project
    end

    def get_project(project_id)
      return @all_projects[project_id]
    end
  end



  def self.db
    @__db_instance ||= DB.new
  end
end
