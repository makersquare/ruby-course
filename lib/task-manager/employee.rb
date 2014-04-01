class TM::Employee

attr_accessor :name
attr_reader :id

@@counter = 0

def initialize(name)
  @name = name
  @id = @@counter += 1
end
end
