
class TM::Project
  attr_reader :id, :name, :task_list

  @@project_list = []

  def initialize(name)
    @name = name
    @@project_list << self
    @id = @@project_list.count
    @task_list = []
  end

  def self.project_list
    @@project_list
  end
end
