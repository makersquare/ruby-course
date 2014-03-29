

module TM
  class TM::Task

    attr_reader :project_id, :description, :priority, :id

    @@current_id = 1

    def initialize(data)
      @project_id = data[:project_id]
      @description = data[:description]
      @priority = data[:priority]
      @id = @@current_id
      @@current_id += 1
    end

  end
end
