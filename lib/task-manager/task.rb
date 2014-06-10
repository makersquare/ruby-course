
class TM::Task

  attr_accessor :name, :status, :creation_date, :priority_number, :description

  def initialize(name, priority_number,description=nil)
    @name = name
    @status = "available"
    @creation_date = Time.now
    @priority_number = priority_number
    @description = description
  end

  def priority_check(priority_number)
    if priority_number > 5 || priority_number < 1
      return nil
    else
      @priority_number
    end
  end

end
