class TaxiMeter
  # TODO
  attr_accessor :miles_driven
  attr_accessor :start_time
  attr_accessor :stop_time
  attr_writer :amount_due

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
  end

  def start
    @start_time = Time.now
  end

  def stop
    if @start_time
      return @stop_time = Time.now
    end
  end

  def amount_due
    if @start_time != nil #Only returns if the meter is running
      #Adds the amount due to distance travelled. Updates to give a 2.50 amount if no distance travelled
      @miles_driven > 0 ? @amount_due += 2.1 + ((@miles_driven*6).ceil)*0.4 : @amount_due += 2.50
      #Adds the amount due to the waiting time
      if @stop_time #This is for if the amount_due is being checked during the ride or not
        @amount_due += (29.0/60)*((@stop_time-@start_time)/60).ceil
      else
        @amount_due += (29.0/60)*((Time.now-@start_time)/60).ceil
      end
      #Adds the amount due to the drunk tax (9PM-4AM)
      @amount_due += 1 if (@start_time.hour >= 21 || @start_time.hour < 4)
      #Makes the amount 13.10 if coming from the airport and the minimum hasn't been met
      @amount_due = 13.10 if @airport && @amount_due < 13.10
      #Returns the amount_due, rounded for cents
      return (@amount_due*100).round(0)
    else
      return 0
    end
  end


end
