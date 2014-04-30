
class TM::Project
  attr_reader :pid, :name
  @@pid = 0

  def initialize(name)
    @name = name
    @pid = @@pid + 1
    @@pid = @pid
  end

  # Used to reset class variables for rspec tests
  def self.reset_class_variables
    @@pid = 0
  end
end
