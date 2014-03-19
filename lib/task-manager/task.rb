
class TM::Task
  attr_reader :proj_id, :description, :priority
  attr_reader :id
  attr_accessor :completed
  attr_reader :time_created
  attr_accessor :time_completed

  @@counter = 0

  def self.gen_id
    @@counter += 1
    @@counter
  end

  def initialize(proj_id, desc, priority)
    @proj_id = proj_id
    @description = desc
    @priority = priority
    @id = TM::Task.gen_id

    # task defaults as incomplete
    @completed = false

    @time_created = Time.now

    @time_completed = nil
  end

end
