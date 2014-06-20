
class TM::Employee
  attr_reader :id, :name, :email

  def self.table_name
    'employees'
  end

  def initialize(args)
    @id    = args[:id]
    @name  = args[:name]
    @email = args[:email]
  end
end
