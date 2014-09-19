module PM
  class Employee
    attr_reader :id, :name, :email, :salary

    def initialize(name, email, salary)
      @name, @email, @salary = name, email, salary
    end
  end
end
