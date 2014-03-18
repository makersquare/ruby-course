
class TM::Project
@@id = 0
attr_reader :name
attr_accessor :tasklist

  def initialize(name)
    @@id += 1
    @name = name
    @tasklist = []
  end

   def self.id
    @@id
  end

end
