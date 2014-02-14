class TaxiMeter
  attr_accessor :amount_due, :miles_driven, :start_time, :stop_time, :airport
  def initialize(airport: false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = 0
    @stop_time = nil
    @airport = airport
  end

  def start
    @start_time = Time.now
    first_sixth
    airport_rate
    add_sixth
  end

  def stop
    @stop_time = Time.now
  end

  def first_sixth
    @miles_driven += (1.0/6.0)
    @amount_due += 2.50
  end

  def add_sixth
    @miles_driven += (1.0/6.0)
    @amount_due +=
  end

  def airport_rate
    if @airport
      @amount_due += 13.10
    end
  end

  def regular_rate
    @amount_due += @miles_driven * 2.40
  end

end
