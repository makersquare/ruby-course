
class TM::Employee
  attr_reader :id, :name, :project_id

  def initialize(args)
    @id    = args[:id]
    @project_id = args[:project_id]
    @name  = args[:name]
  end
end
