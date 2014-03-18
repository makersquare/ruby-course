
class TM::Project
  attr_reader :name, :id
  @@current_id = 1

  def self.current_id=(current_id)
    @@current_id = current_id
  end


  def initialize(name)
    @name = name
    @id = @@current_id
    @@current_id = @@current_id + 1
  end

end
