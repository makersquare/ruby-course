class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @airport = airport
  end

  def start
    @start_time = Time.now
  end

  def amount_due
    if @miles_driven >= 1.0/6.0
      @amount_due += 2.50
    end
    if @airport
      @amount_due += 13.10
    end
    @amount_due
  end

  def stop
    @stop_time = Time.now
  end


end
