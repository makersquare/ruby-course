
class Request
  attr_reader :customer, :breed, :price
  attr_accessor  :status, :puppy

  def initialize (customer, breed)
    pricing = {
      dobermanpinscher: 800,
      chihuahua: 600,
      americanbulldog: 900,
      dingo: 1200,
      poodle: 1500
    }
    @customer = customer
    @breed = breed
    @status = :pending
    @puppy = nil
    @price = pricing[@breed]
  end
end