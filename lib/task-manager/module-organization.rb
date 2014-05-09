module Organization
  attr_reader :created, :complete, :complete_date, :id
  attr_accessor :name


  def complete(complete=false)
    @complete = complete
  end

  def mark_complete
    @complete = true
    @complete_date = Time.now
  end

end
