class Puppy
  attr_reader :name, :dob, :breed, :status, :id

  def initialize (name, dob, breed, id, status = 'available')
    @name = name
    @dob = dob
    @breed = breed
    @id = id
    @status = status
  end
end