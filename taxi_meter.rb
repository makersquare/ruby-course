require 'time'

class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time
  # TODO

  def initialize(elapsed = 0, airport: false)
    @elapsed = 0
    @miles_driven = 0
    @airport = airport
  end

  def amount_due
    elapsed = @stop_time - @start_time
    @distance = miles_driven
    sixth = (miles_driven * 6).ceil
    due = 210 + (40 * sixth)

      if @airport == true
          if due > 1310
             due = due
          else
             due = 1310
          end
      else
        due
      end

  end #amount_due


  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end




end #end TaxiMeter
