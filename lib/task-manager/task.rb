
class TM::Task

  attr_reader :project_id, :description, :priority
  attr_reader :id, :timestamp
  attr_accessor :complete

  @@id_counter = 0
  @@tasks = []

  def initialize(project_id, description, priority)
    @@id_counter += 1
    @id = @@id_counter
    @timestamp = Time.now
    @project_id = project_id
    @description = description
    @priority = priority
    @complete = false
    @@tasks << self
  end

  def to_s
    status = @complete? 'complete  ' : 'incomplete'
    "#{@id} | #{status} | #{description}"
  end

  def complete?
    @complete == true
  end

  def self.mark_complete(tid)
    t = @@tasks.select {|t| t.id == tid}.first
    t.complete = true
  end

  def self.reset_class_vars
    @@id_counter = 0
    @@tasks = []
  end

end
