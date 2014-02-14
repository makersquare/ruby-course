class TaxiMeter

  attr_reader :start_time, :stop_time
  attr_accessor :amount_due, :miles_driven

  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
  end

  def one_sixth
    1.0 / 6.0
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def amount_due
    if @miles_driven >= 0.166666667
      @amount_due += 250
    end
    if @airport
      if @amount_due < 1310
        @amount_due = 1310
      end
    end
    @amount_due
  end
end

