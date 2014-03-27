class TM::Project
attr_reader :name, :id
attr_accessor :tasks, :employees
@@id_counter = 1
def initialize(name)
  @name = name
  @id = @@id_counter
  @@id_counter += 1
end

end








