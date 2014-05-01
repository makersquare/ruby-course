module Organization
  attr_reader :create_date, :complete, :complete_date, :id
  attr_accessor :name,
  # attr_accessor :name,:call_count_reset,:call_count

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



  # def call_count_reset
  #   @call_count = 1
  # end

  # def id
  #   @id = @id_call_count
  # end

  # def id_call_count
  #   @id_call_count = 1
  # end

  # def increment_id
  #   ## Implement a method for a unique ID
  #   ## Should be unique for projects
  #   @id = @call_count
  #   @call_count += 1
  # end



end
