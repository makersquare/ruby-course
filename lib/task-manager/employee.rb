class TM::Employee
  attr_reader :name, :employee_id

  @@employeecount = 0

  def initialize(name)
    @name = name
    @@employeecount += 1
    @employee_id = TM::Employee.gen_id
  end

  def self.gen_id
    @@employeecount
  end
end
