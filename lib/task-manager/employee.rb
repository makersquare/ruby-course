class TM::Employee
  attr_accessor :eid, :name

  def initialize(eid=nil, name=nil)
    employee = TM.orm.show_employee
    @eid = employee[0]
    @name = employee[1]
  end
end
