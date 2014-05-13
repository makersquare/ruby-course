module TM

  class DB
    attr_reader :tasks, :projects

    def initialize
      @projects = {}
      @project_count = 0
      @tasks = {}
    end

    def create_project(data)
      @project_count += 1
      data[:id] = @project_count
      @projects[data[:id]] = data
      TM::Project.new(data[:name], data[:id])
    end

    def get_project(id)
      data = @projects[id]
      if !data.nil?
        TM::Project.new(data[:name], data[:id])
      end
    end

    def update_project(id, data)
      old_data = @projects[id]
      old_data.merge!(data)
    end

    def destroy_project(id)
      @projects.delete(id)
    end

    def build_project(data)
      TM::Project.new(data[:name], data[:id])
    end

    # def get_tasks_from_project_id(pid)
    #   @tasks.select {|task| task.project_id == pid}
    # end

  end

    def self.db
      @__db_instance ||= DB.new
    end

end
