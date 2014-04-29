
class TM::Project
  attr_reader :id
  attr_accessor :name

  @@class_id = 1

  def initialize(name=nil)
    @name = name
    @id = @@class_id
    @@class_id +=1
  end
end
