module TM
  class ProjectsOfEmployee < UseCase
    def run(inputs)
      @database = TM.database
      employee = @database.get_employee(inputs[:employee_id].to_i)
      return failure(:employee_not_found) if employee.nil?
      selection = @database.membership.select {|x| x[:employee_number] == employee.id}
      selection_new = []
        selection.each do |x|
        selection_new.push(x[:project_number])
        end
      selection_newer = selection_new.map{|x| @database.get_project(x)}
      return failure(:no_projects_of_employee) if selection_new == []
      # Return a success with relevant data
      success :employee => employee, :projects => selection_newer
    end
  end
end
