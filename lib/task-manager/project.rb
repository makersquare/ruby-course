
class TM::Project
  attr_reader :name, :id
  def initialize(name)
  @@ids=[]
  @name=name
  @id=@@ids.count
  @@ids<<self
  end
end
