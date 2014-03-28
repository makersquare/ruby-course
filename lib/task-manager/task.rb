class TM::Task
  attr_reader :id, :creation_date
  attr_accessor :complete, :descr, :proj_id, :priority_num, :emp_id
  @@id = 0
  def initialize(proj_id,emp_id, descr, priority_num)
     @proj_id = proj_id
     @descr = descr
     @@id += 1
     @id = @@id
     @priority_num = priority_num
     @complete = false
     @creation_date = Time.now    #stub time in rspec.
     @emp_id = emp_id # add this in to make relationship
  end

end

