class TaxiMeter
  attr_accessor :miles_driven, :start_time, :stop_time
  attr_reader :airport
  attr_writer :amount_due

  def initialize(airport: false)
    # Amount due is recorded in cents
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
  end

  def amount_due
      # Find wait time in minutes between start time and current time.
      t = Time.now
      if t.hour > @start_time.hour
        wait_time = ((60 - @start_time.min) + t.min) + (60 * ((t.hour - @start_time.hour) - 1))
      elsif t.hour < @start_time.hour
        wait_time = t.hour * ((60 - @start_time.min) + t.min)
      elsif t.hour == @start_time.hour
        minutes = t.min
        minutes2 = @start_time.min
        wait_time = (minutes - minutes2)
      end

      # Calculate amount due with miles driven and wait time.
      if @miles_driven <= (1.0 / 6.0)
        @amount_due = (250 + ((2900 / 60.0) * wait_time)).round(0)
      elsif @miles_driven > (1.0 / 6.0)
        one_sixth = (@miles_driven * 6) - 1
        @amount_due = ((250 + (one_sixth * 40)) + ((2900 / 60.0) * wait_time)).round(0)
      end

      if self.airport != true
        @amount_due
      else
        if @amount_due < 1310
          @amount_due = 1310
        else
          @amount_due
        end
      end

  end

  def start
    self.start_time = Time.now
  end

  def stop
    self.stop_time = Time.now
    #Check that after stop_time is called, amount_due doesn't change.
  end

end


