
class TM::Project
  @@counter = 1
  attr_accessor :name
  attr_reader :id
  def initialize(name)
    @name = name
    @id = @@counter
    @@counter += 1
  end
end
