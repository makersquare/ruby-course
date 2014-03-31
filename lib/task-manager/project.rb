class TM::Project

  @@counter = 0

  attr_reader :project_name, :id
  # attr_accessor :tasks

  def self.generate_id
    @@counter +=1
    @@counter
  end

  def initialize(project_name)
    @project_name = project_name
    @id = TM::Project.generate_id

  end
end
