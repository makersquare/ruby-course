module TM
  class ShowCompletedTasksinProject < UseCase

    def run(inputs)
      proj = TM.db.get_project(inputs[:project_id].to_i)
      return failure (:project_does_not_exist) if proj.nil?

      task_arr = show_completed_tasks(proj.id)
      return failure (:there_are_no_completed_tasks) if task_arr.length == 0

      # Return a success with relevant data
      success :project => proj, :task_arr => task_arr
    end

    def show_completed_tasks(project_id)
      TM.db.sort_comp_tasks(project_id)
    end

  end
end
