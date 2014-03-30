class TM::Employee
attr_reader :name, :eid

  @@employee_counter = 0

  def self.gen_id
    @@employee_counter += 1
    @@employee_counter
  end

  def initialize(name)
    @name = name
    @eid = TM::Employee.gen_id
  end

end
