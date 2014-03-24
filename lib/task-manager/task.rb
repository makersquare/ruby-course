class TM::Task
  attr_reader :task_id, :creation_date, :priority_num
  attr_accessor :complete, :descr, :id
  @@id = 0
  def initialize(proj_id, descr, priority_num)
     @proj_id = proj_id
     @descr = descr
     @@id += 1
     @id = @@id
     @priority_num = priority_num
     @complete = false
     @creation_date = Time.now    #stub time in rspec.
     @task_id = task_id
  end

end

