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
end
