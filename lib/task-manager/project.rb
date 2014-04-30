
class TM::Project
  attr_reader :name, :id
  @@project_id = 0

  def initialize(name)
    @name = name
    @@project_id += 1
    @id = @@project_id
    @time = Time.now
  end

  def self.reset_class_variables
    @@project_id = 0
  end
end
