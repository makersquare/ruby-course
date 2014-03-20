class TM::Employee
  attr_reader :name, :employee_id

  @@current_id = 1

  def initialize(name)
    @name = name
    @employee_id = @@current_id
    @@current_id = @@current_id + 1
    TM::DB.instance.all_employees[@employee_id] = self
  end

end

