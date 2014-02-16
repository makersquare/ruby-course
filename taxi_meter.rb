require 'time'

class TaxiMeter

  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time, :current_time, :rolling_time, :airport
  # TODO

  def initialize(elapsed = 0, airport: false)
    @elapsed = 0
    @miles_driven = 0
    @airport = airport
  end

  def amount_due
    per_minute = 0.4833
      if !@stop_time
        #puts "#{start_time}"
        #puts "#{Time.now}"
          rolling_time = Time.now
          time_elapsed = (rolling_time - @start_time) / 60

        time_fare = (time_elapsed * per_minute) * 100
        else
          time_elapsed = (@stop_time - @start_time) / 60
          time_fare = (time_elapsed * per_minute) * 100
      end
    sixth = (miles_driven * 6).ceil
    dist_fare = (40 * sixth)

    if dist_fare == 0
      dist_fare = -210
    end
    #puts "#{dist_fare}"
    #puts "#{time_fare}"
    #puts "#{late_night}"
    #puts "#{airport}"
    due = 210 + dist_fare + time_fare
      if late_night == true && @airport == false
        due = (due + 100).round
      end
      if @airport == true
          if due >= 1310 && late_night == true
             due = (due + 100).round
          elsif due < 1310 && late_night == true
             due = 1410
          elsif due < 1310 && late_night == false
            due = 1310
          end
      end
      due.round
  end #amount_due

  def start
    @start_time ||= Time.now
  end

  def stop
    @stop_time ||= Time.now
  end

  def late_night
     t = @start_time
    if t.hour >= 21 || t.hour <= 4
      true
    else
      false
    end
  end

end #end TaxiMeter
