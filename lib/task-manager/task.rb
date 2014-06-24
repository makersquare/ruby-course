class TM::Task
  attr_reader :id, :description, :priority, :completed, :created_at
              # :project_id, :employee_id,

  def initialize(args)
    @id          = args[:id]
    @description = args[:description]
    @priority    = args[:priority]
    # @project_id  = args[:project_id]
    # @employee_id = args[:employee_id]
    @completed   = args[:completed]
    @created_at  = args[:created_at]
  end
end
