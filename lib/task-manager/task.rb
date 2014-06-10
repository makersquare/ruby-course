
class TM::Task
  attr_reader :project, :description, :priority, :created, :complete, :id

  @@counter=0
  @@task_list={}

  def self.task_list
    @@task_list
  end

  def initialize(project_id, description, priority=5)
    @@counter += 1
    @id = "P#{project_id}_T#{@@counter}".to_sym
    @project = project_id
    @priority = priority
    @description = description
    @created = Time.now()
    @complete = false
    @@task_list[@id] = self
  end

  def done
    @complete = true
  end

end
