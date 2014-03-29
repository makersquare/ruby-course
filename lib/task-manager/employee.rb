class TM::Employee
  attr_reader :name, :employee_id

  @@employeecount = 0

  def initialize(name)
    @name = name
    @employee_id = TM::Employee.gen_id
    @@employeecount += 1
  end

  def self.gen_id
    @@employeecount
  end
end
