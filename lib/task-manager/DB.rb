module TM
  class DB
    attr_reader :tasks, :projects
    def initialize
      @projects = {}
      @project_count = 0
    end

#takes data as a hash
    def create_project(data)
      @projects[:id] = TM::Project()

    end

#gets project according to id
    def get_project(id)
    end


    def destroy_project(id)
    end

    def build_project(data)
      Project.new(data[:name], data[:id])
    end

  end

  def self.db
    @__db_instance ||= DB.new
  end
end
