class TM::Task
  attr_reader :id, :description, :priority, :completed, :created_at

  def initialize(args)
    @id          = args[:id]
    @description = args[:description]
    @priority    = args[:priority]
    @completed   = args[:completed]
    @created_at  = args[:created_at]
  end
end
