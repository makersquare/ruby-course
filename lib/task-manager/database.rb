module TM

  # Our singleton getter
  def self.db
    @__db_instance ||= Database.new
  end

  # Our singleton class
  class Database
    attr_accessor :projects

    def initialize
      @projects = []
      @tasks = {}
    end

    def add_project(name)
      newproject = TM::Project.new(name)
      @projects.push(newproject)
    end

    def add_new_task(description, project_id, priority)
      project_id = project_id.to_i
      priority = priority.to_i
      proj = @projects.find{ |project| project.id == project_id}
      proj.add_task(TM::Task.new(description, project_id, priority))
    end

  end

end
