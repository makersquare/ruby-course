require 'time'

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

    seven_hours = 420 * 60
    if @start_time.between?(Time.parse('9 pm'), (Time.parse('9 pm') + seven_hours)) then @amount_due += 100 end
  end

  def stop
    @stop_time = Time.now
    sixth = (1.0/6.0)
    @amount_due += 250
    @miles_driven <= (sixth) ? @amount_due : @miles_driven -= sixth



    @amount_due
  end



end
