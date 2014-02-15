require 'time'

class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time, :current_time, :rolling_time
  # TODO

  def initialize(elapsed = 0, airport: false)
    @elapsed = 0
    @miles_driven = 0
    @airport = airport
  end

  def amount_due
    per_minute = 48
      if !@stop_time
          rolling_time = Time.now
          time_elapsed = (rolling_time - @start_time) / 60
          if time_elapsed > 0 && time_elapsed % 60 == 0
            time_fare = 2900 * (time_elapsed / 60)
          else
           time_fare = time_elapsed * per_minute
          end

      end
    sixth = (miles_driven * 6).ceil
    dist_fare = (40 * sixth)

    if dist_fare == 0
      dist_fare = -210
    end
    puts "#{dist_fare}"
    #puts "#{time_fare}"
    due = 210 + dist_fare + time_fare

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
