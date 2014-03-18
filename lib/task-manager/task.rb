
class TM::Task
  attr_reader :proj_id, :description, :priority, :id

  # @@counter

  # def self.gen_id
  #   @@counter += 1
  #   @@counter
  # end

  def initialize(proj_id, desc, priority)
    @proj_id = proj_id
    @description = desc
    @priority = priority
  #   # @id = TM::Task.gen_id
  end


end
