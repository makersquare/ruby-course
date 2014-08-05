class Puppy
  attr_reader :name, :dob, :breed, :status, :id

  def initialize (name, dob, breed, id, status = 'available')
    @name = name
    @dob = dob
    @breed = breed
    @id = id
    @status = status
  end

  def sold?
    @status == "sold"
  end

  def sold!
    @status = "sold"
  end

  def available?
    @status == available
  end

  def age
    Time.now - Time.parse(@dob)
  end
end