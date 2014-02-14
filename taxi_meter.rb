class TaxiMeter

  attr_accessor :meter, :amount_due, :miles_driven, :start_time, :stop_time

  def initialize
    @meter = meter
    @amount_due = 0
    @miles_drive = 0
    @start_time = start_time
    @stop_time = stop_time
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end



end
