
class Request
  attr_reader :customer, :breed
  attr_accessor  :status, :puppy

  def initialize (customer, breed, id, created_at, status = :pending, puppy = nil)
    @id = id
    @created_at = created_at
    @customer = customer
    @breed = breed
    @status = status
    @puppy = puppy
  end
end

