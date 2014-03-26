class TM::Employee
  attr_reader :name, :id, :id_counter
  attr_accessor :projects, :tasks
  @@id_counter = 1
  def initialize(name)
    @name = name
    @id = @@id_counter
    @@id_counter += 1
  end

  def self.id_counter=(value)
    @@id_counter = value
  end
end
