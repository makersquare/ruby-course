module TM
  class AddEmployee

    def run(name)
      emp = Employee.new(name)
      DB.instance.employees << emp
      emp
    end
    
  end

end