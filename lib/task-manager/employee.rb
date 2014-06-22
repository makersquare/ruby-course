class TM::Employee
  attr_accessor :name

  def initialize(eid=nil, name=nil)
    @name = name
    @eid = eid
  end

  def self.add_employee(eid, name)
    new_employee = TM.orm.add_employee(name)
  end
end
