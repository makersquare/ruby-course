require 'time'

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
      t = Time.now

      # Reads amount due as 0 if taxi meter hasn't started.
      if @start_time == nil
        return @amount_due = 0
      end

      # Finds wait time in minutes.
      if @stop_time == nil
        wait_time = ((t - @start_time) / 60).ceil
      else
        wait_time = ((@stop_time - @start_time) / 60).ceil
      end

      # Calculates amount due with miles driven and wait time.
      if @miles_driven <= (1.0 / 6.0)
        @amount_due = (250 + ((2900.0 / 60.0) * wait_time)).round(0)
      else
        one_sixth = (@miles_driven * 6).ceil
        @amount_due = ((210 + (one_sixth * 40)) + ((2900.0 / 60.0) * wait_time)).round(0)
      end

      # Adds $1 if start time is between 9pm and 4am
      if @start_time.hour <= 4 || @start_time.hour >= 21
        @amount_due += 100
      else
        @amount_due
      end

      # Ensures minimum of $13.10 for fares starting from ABIA.
      if @airport != true || @amount_due >= 1310
        @amount_due
      else
        @amount_due = 1310
      end

  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

end


