class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time

  def initialize
    @amount_due = 0
    @miles_driven = 0
  end

  def start
    @start_time = Time.now
  end

  def amount_due
    if @miles_driven >= 1.0/6.0
      @amount_due += 2.50
    end
  end

  def stop
    @stop_time = Time.now
  end


end
