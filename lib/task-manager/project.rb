class TM::Project
  attr_reader :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def save!
    @id = TM.db.create_project(@name)
  end

  def self.get_complete_tasks
    project_tasks = TM.db.get_tasks({"pid"=>@id, "complete"=>true})
    project_tasks.sort_by { |t| t.created }
  end

  def self.get_incomplete_tasks
    project_tasks = TM.db.get_tasks({"pid"=>@id, "complete"=>false})
    project_tasks.sort_by { |t| [(t.priority * -1), t.created] }
  end
end
