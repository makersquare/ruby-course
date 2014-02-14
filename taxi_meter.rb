class TaxiMeter
  attr_accessor :miles_driven, :start_time, :stop_time
  attr_writer :amount_due

  def initialize
    # Amount due is recorded in cents
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
  end

  def amount_due
      if self.miles_driven <= (1.0 / 6.0)
        @amount_due = 250
      elsif self.miles_driven > (1.0 / 6.0)
        one_sixth = (self.miles_driven * 6) - 1
        @amount_due = 250 + (one_sixth * 40)
      end
  end

  def start
    self.start_time = Time.now
  end

  def stop
    self.stop_time = Time.now
  end

end
