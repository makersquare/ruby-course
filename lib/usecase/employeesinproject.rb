module TM
  class EmployeesInProject < UseCase
    def run(inputs)
      @database = TM.database
      project = @database.get_project(inputs[:project_id].to_i)
      return failure(:project_not_found) if project.nil?
      selection = @database.membership.select {|x| x[:project_number] == project.id}
      selection_new = []
        selection.each do |x|
        selection_new.push(x[:employee_number])
        end
      selection_newer = selection_new.map{|x| @database.get_employee(x)}
      return failure(:no_employees_in_project) if selection_new == []
      # Return a success with relevant data
      success :project => project, :employees => selection_newer
    end
  end
end
