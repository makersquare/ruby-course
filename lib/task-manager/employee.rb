class TM::Employee
  attr_reader :name, :id, :tasks

  @@employeecount = 0

  def initialize(name)
    @name = name
    @id = TM::Employee.gen_id
    @@employeecount += 1
    @tasks = []
  end

  def self.gen_id
    @@employeecount
  end

  def taketask(task)
    @tasks.push(task)
  end

end
