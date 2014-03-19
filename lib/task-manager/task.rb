require 'time'

class TM::Task
  @@counter = 0
  def self.generate_id
    @@counter+=1
    @@counter
  end


  attr_reader :description, :id, :date_created
  attr_accessor :priority, :project_id, :complete

  def initialize(description, priority=nil, project_id=nil, complete=false)
    @project_id = project_id
    @description = description
    @priority = priority
    @complete = complete
    @id = TM::Task.generate_id
    @date_created = Time.now
  end



end
