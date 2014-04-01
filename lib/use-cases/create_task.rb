module TM
  class CreateTask < UseCase
    def run(inputs)
      pid = inputs[:pid]
      priority = inputs[:eid]
      description = inputs[:description]

      task = TM.DB.add_task_to_project(description, priority, pid)
      return failure(:provide_info) if (pid == '') || (priority == '') || (description == '')
      success :task => task
    end
  end
end

