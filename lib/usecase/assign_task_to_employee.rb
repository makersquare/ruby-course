module TM
  class AssignTaskToEmployee < UseCase
    def run(inputs)
      tid = inputs[:tid]
      eid = inputs[:eid]

      assigned_task = TM.db.assign_task(tid, eid)

      success(assigned_task: assigned_task)
    end

  end
end
