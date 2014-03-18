
class TM::Task
attr_reader :name, :task_id

  @@task_counter = 0

  def initialize(name)
    @name = name
    @@task_counter += 1
    @task_id = @@task_counter
  end

end
