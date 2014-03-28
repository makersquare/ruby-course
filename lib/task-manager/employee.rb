module TM
  class Employee
    @@num_emp = 0

    attr_reader :id
    attr_accessor :name

    def initialize(name)
      @name = name
      @@num_emp += 1
      @id = @@num_emp
    end

  end

end
