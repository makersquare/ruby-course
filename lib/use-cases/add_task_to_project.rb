module TM
  class AddTaskToEmployee < UseCase
    def run(inputs)
      tid = inputs[:tid]
      eid = inputs[:eid]
      task = TM.DB.get_task(tid)
      emp = TM.DB.get_employee(eid)
      tasks = TM.DB.assign_task(tid, eid)
      success :tasks => tasks
    end
  end
end

