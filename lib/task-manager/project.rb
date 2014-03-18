
class TM::Project

  @@id_counter = 0

  attr_reader :project_name

  def initialize(project_name)
    @project_name = project_name
    @@id_counter += 1

  end

  def id_counter
    @@id_counter
  end
end
