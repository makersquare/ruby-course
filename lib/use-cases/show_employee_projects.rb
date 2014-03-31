
module TM
  class ShowProjects < UseCase
    def run(inputs)
      eid = inputs[:eid]
      return failure(:employee_doesnt_exist) if eid.nil?
      projects = TM.DB.get_emp_membership(eid)
      success :projects => projects
    end
  end
end
