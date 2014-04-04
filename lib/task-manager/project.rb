
class TM::Project
  attr_accessor :name
  attr_accessor :id
  attr_reader :tasks

  @@counter = 0

  def initialize(name)
    @name = name

    @@counter += 1
    @id = @@counter

    @tasks = []
  end

end
