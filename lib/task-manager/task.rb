
class TM::Task
  @@counter = 0

  attr_reader :project_id, :description, :id
  attr_accessor :priority, :project_id, :complete


  def self.generate_id
    @@counter += 1
    @@counter
  end

  def initialize(description, complete=false, priority=nil, project_id=nil)
    @project_id = project_id
    @description = description
    @priority = priority
    @complete = complete
    @id = TM::Task.generate_id
  end


end
