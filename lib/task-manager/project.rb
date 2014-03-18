
class TM::Project
attr_reader :name, :project_id

  @@project_counter = 0

  def initialize(name)
    @name = name
    @@project_counter += 1
    @project_id = @@project_counter
  end

end

