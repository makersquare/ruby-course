
class TM::Employee
  attr_reader :id, :name

  def initialize(args)
    @id    = args[:id]
    @project_id = args[:project_id]
    @name  = args[:name]
  end

  private

  def project_id
    @project_id
  end
end
