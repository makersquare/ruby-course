class TM::Employee
@@id = 0
attr_reader :id, :name
  def initialize(name)
    @@id += 1
    @id = @@id
    @name = name
  end

end
