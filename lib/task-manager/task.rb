
require_relative './module-organization'

class TM::Task

  include Organization


  attr_accessor :priority, :complete, :description
  attr_reader :created

  def initialize(description, priority=1)
    @description = description
    @created = Time.now
    @priority = (1..5)
    @complete = false
  end

  def mark_complete
    @complete = true
  end

  def change_description(description)
    @description = description
  end

  def change_priority(priority)
    @priority = priority
  end



end
