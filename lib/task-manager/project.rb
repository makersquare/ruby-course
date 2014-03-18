
class TM::Project
  attr_reader :name, :id

  @@projectcount = 0

  def initialize(name)
    @name = name
    @@projectcount += 1
    @id = @@projectcount
  end
end
