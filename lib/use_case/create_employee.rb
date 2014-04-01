module TM
  class CreateEmployee < UseCase
    def run(name)
      employee = TM::db.create_employee(name)
      return success :employee => employee
    end
  end
end
