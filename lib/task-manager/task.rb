
require_relative './module-organization'

class TM::Task

  include Organization


  attr_accessor :priority, :complete, :description
  attr_reader :created

  def initialize(description, priority=1)
    @description = description
    @created = Time.now
    @priority = priority
    @complete = false
  end


end
