module TM
  class Employee

    attr_reader :name, :id

    @@current_id = 1

    def initialize(name)
      @name = name
      @id = @@current_id
      @@current_id += 1
    end

  end
end
