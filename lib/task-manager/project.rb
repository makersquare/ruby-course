
class TM::Project
  attr_reader :name, :project_id, :tasks, :projectlist, :employees_on_project

  @@projectcount = 0

  def initialize(name)
    @name = name
    @@projectcount += 1
    @project_id = TM::Project.gen_id
    @tasks = {}
    @employees_on_project = []
  end

  def self.gen_id
    @@projectcount
  end
end
