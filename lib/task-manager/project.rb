
class TM::Project
@@id = 0
attr_reader :name

  def initialize(name)
    @@id += 1
    @name = name
  end

   def self.id
    @@id
  end

end
