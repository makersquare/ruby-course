class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time

  def initialize
    @amount_due = 0
    @miles_driven = 0

  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def amount_due
    if @miles_driven = 0
      0
    elsif @miles_drive = 1.0 / 6.0
      2.5
    else
      @miles_driven = @miles_driven + 2.5 + (2.4 * 1.0 / 6.0)
    end
  end
end
