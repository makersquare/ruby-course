class TM::Employee

  attr_reader :name, :id

  @@eid = 0

  def initialize(name)
    @name = name
    @id = @@eid
    @@eid += 1
  end

  def assign_project()
  end

  def assign_task()
  end

end
