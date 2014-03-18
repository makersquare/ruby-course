
class TM::Task
attr_reader :name, :task_id, :description

  @@task_counter = 0

  def initialize(name, description)
    @name = name
    @@task_counter += 1
    @task_id = @@task_counter
    @description = description
  end

end
