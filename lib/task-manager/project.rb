
class TM::Project

  @@project_id = 0

  attr_reader :project_name

  def initialize(project_name)
    @project_name = project_name
    @@project_id += 1

  end

  def project_id
    @@project_id
  end
end
