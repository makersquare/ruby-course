module Organization
  attr_reader :create_date, :complete, :id, :complete_date
  attr_accessor :name

  def created
    @create_date = Time.now
  end

  def complete(complete=false)
    @complete = complete
  end

  def mark_complete
    @complete = true
    @complete_date = Time.now
  end

  def call_count
    @call_count = 1
  end

  def id
    ## Implement a method for a unique ID
    ## Should be unique for projects
    @id = @call_count
    @call_count += 1

  end

end
