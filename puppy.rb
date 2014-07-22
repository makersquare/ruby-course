class Request
  attr_reader :customer_name, :breed, :status

  def initialize(customer_name, breed, status = nil)
    @customer_name = customer_name
    @breed = breed
  end
end

class Puppy
  attr_reader :name, :age, :breed

  def initialize(name, age, breed = "german shepherd")
    @name = name
    @age = age
    @breed = breed
  end



end

class Store
  attr_reader

  def initialize(name="Cruel De Villa Puppy Store")
    @name = name
    @requests = []
    @completed_req = {}
    @completed_req_count = Hash.new { |hash, key| hash[key] = 0 }
  end



end

class PuppyGarden
  attr_reader :name, :puppies

    def initialize(name = "AMK")
      @name = name
      @puppies = []
    end

    def add_new_puppy(name, age, breed)
      new_pup = Puppy.new(name, age, breed)
      @puppies << new_pup
    end

    def kill_puppy(name, age, breed)
      @puppies.delete()
    end



end
