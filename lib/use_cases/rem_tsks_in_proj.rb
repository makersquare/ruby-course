module TM
  class ShowRemainingTasksinProject < UseCase

    def run(inputs)

      proj = TM.db.get_project(inputs[:project_id].to_i)
      return failure (:project_does_not_exist) if proj.nil?

      task_arr = show_remaining_tasks(proj.id)
      return failure (:there_are_no_incomplete_tasks) if task_arr.length == 0

      # Return a success with relevant data
      success :project => proj, :task_arr => task_arr
    end

    def show_remaining_tasks(proj_id)
      TM.db.sort_inc_tasks(proj_id)
    end

  end
end
