module TM
  class TM::Task

    attr_reader :project_id, :description, :priority

    def initialize(data)
      @project_id = data[:project_id]
      @desription = data[:description]
      @priority = data[:priority]
    end

  end
end
