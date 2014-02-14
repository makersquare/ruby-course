class TaxiMeter
  # TODO
  attr_accessor :miles_driven
  attr_accessor :start_time
  attr_accessor :stop_time
  attr_writer :amount_due

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0.0
    @start_time = nil
    @stop_time = nil
    @airport = airport
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def amount_due
    if @start_time != nil #Only returns if the meter is running
      #Adds the amount due to distance travelled. Only happens if distance has been travelled
      @amount_due += 2.1 + ((@miles_driven*6).ceil)*0.4 if (@miles_driven > 0)
      #Adds the amount due to the waiting time
      @amount_due += (29.0/60)*(Time.now-@start_time)/60
      #Adds the amount due to the drunk tax (9PM-4AM)
      @amount_due += 1 if (@start_time.hour >= 21 || @start_time.hour < 4)

      #Returns the amount_due, rounded for cents
      return @amount_due.round(2)
    else
      return 0
    end
  end


end
