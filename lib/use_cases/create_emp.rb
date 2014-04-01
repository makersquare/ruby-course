module TM
  class CreateEmployee < UseCase

    def run(inputs)

     emp = create_new_employee(inputs[:name])
      # Return a success with relevant data
     success :employee => emp
    end

    def create_new_employee(name)
      TM.db.create_emp(name)
    end

  end
end
