module TM
  class CreateEmployee < UseCase
    def run(inputs)
      return failure(:need_at_least_two_names) if !(inputs[:name].include?(" "))
      employee = TM.db.create_employee(inputs[:name])

      success :employee => employee
    end
  end
end
