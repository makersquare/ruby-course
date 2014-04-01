module TM
  class ShowEmployeesInProject < UseCase

    def run(inputs)
      proj = TM.db.get_project(inputs[:project_id].to_i)
      return failure(:project_does_not_exist) if proj.nil?

      emps_arr = show_emps_in_proj(proj.id)
      return failure(:no_employees_in_project) if emps_arr.length == 0

      # Return a success with relevant data
      success :project => proj, :employees => emps_arr
    end

    def show_emps_in_proj(project_id)
      TM.db.get_proj_emps(project_id)
    end

  end
end
