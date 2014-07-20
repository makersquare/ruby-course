class Person
  attr_reader :money

  def initialize(amount)
    @money = amount
  end

  def get_paid(salary)
    @money += salary
  end
end