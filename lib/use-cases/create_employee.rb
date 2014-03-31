module TM
  class CreateEmployee < UseCase
    def run(inputs)
      emp_name = inputs[:employee]
      employee = TM.DB.create_employee(emp_name)
      return failure(:provide_an_employee_name) if emp_name == ''
      success :employee => employee
    end
  end
end

