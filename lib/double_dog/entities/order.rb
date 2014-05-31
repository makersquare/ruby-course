module DoubleDog
  class Order
    attr_reader :id, :employee_id, :items

    def initialize(id, employee_id, items)
      @id = id
      @employee_id = employee_id
      @items = items
    end

  end
end
