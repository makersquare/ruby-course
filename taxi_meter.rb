class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time
  attr_reader :stop_time

  def initialiaze
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  # def drive(miles)
  #   @miles_driven = miles
  #   @amount_due = miles / 6.0 * 15.00
  # end

  def amount_due
    first_sixth_cost = 250
    each_sixth_cost = (@miles_driven * 6.0 - 1) * 240 / 6.0
    @amount_due = first_sixth_cost + each_sixth_cost
  end
end
