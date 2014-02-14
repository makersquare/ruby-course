class TaxiMeter
  attr_reader :amount_due, :start_time, :stop_time
  attr_accessor :miles_driven

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
  end

  def start
    @start_time = Time.now
    if @airport then @amount_due += 1310 end
    if @start_time.
  end

  def stop
    @stop_time = Time.now
    sixth = (1.0/6.0)
    if @miles_driven <= (1.0/6.0)
      @amount_due += 250
    end
  end



end
