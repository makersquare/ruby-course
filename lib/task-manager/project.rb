
class TM::Project
  attr_reader :name, :id

  def initialize(name)
    @name = name
    @id = Random.rand
  end

end
