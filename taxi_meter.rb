class TaxiMeter

  attr_accessor :amount_due, :miles_driven

  def initialize
    @amount_due = 0
    @miles_driven = 0
  end

  def one_sixth
    1.0 / 6.0
  end


end

