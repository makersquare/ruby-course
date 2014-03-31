module TM
  class CreateEmployee < UseCase
    def run(inputs)
      name = inputs[:name]
      return failure(:no_name_provided) if name == nil || name == ''
      employee = TM.db.create_employee(name)
      success(employee: employee)
    end
  end
end
