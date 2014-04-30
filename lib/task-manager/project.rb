
class TM::Project
  attr_reader :name, :id
  attr_accessor :tasks
  @@project_id = 0

  def initialize(name)
    @name = name
    @@project_id += 1
    @id = @@project_id
    @time = Time.now
    @tasks = []
  end

  def new_task(description, priority)
    @tasks << TM::Task.new(@id, description, priority)
  end

  def self.reset_class_variables
    @@project_id = 0
  end
end
