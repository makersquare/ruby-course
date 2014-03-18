
class TM::Task
attr_reader :project_id, :description, :priority, :timecreated
attr_accessor :complete

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @complete = false
    @timecreated = Time.now
  end
end
