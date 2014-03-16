class Event
  attr_accessor :title, :capacity, :clicker

  def initialize(title, capacity, opening_time=nil, closing_time=nil)
    @title = title
    @capacity = capacity
    @clicker = Clicker.new
  end

  def event_hours(open, close)
    @opening_time = open
    @closing_time = close
  end

  def open?
    if Time.now >= @opening_time && Time.now <= @closing_time
      true
    else
      false
    end
  end

  def admit_attendee(attendee)
    @clicker.click(attendee)
  end

  def method_name
    
  end
end