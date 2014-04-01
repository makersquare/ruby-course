module TM
  class ListEmployees < UseCase
    def run
      employees_list = TM::db.employees_list
      return success :employees_list => employees_list
    end
  end
end
