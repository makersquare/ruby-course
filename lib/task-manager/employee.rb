class TM::Employee
  attr_reader :name, :employee_id

  @@id_counter = 0

  def initialize(name)
    @name = name
    @@id_counter += 1
    @employee_id = @@id_counter

  end

end
