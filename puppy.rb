class Request
  attr_reader :customer_name, :breed, :status

  def initialize(customer_name, breed, status = nil)
    @customer_name = customer_name
    @breed = breed
    @status = status
    @price = {
      "german shepherd" => 300,
      "poodle" => 400,
      "pomenarian" => 700,
      "collie" => 800,
      "samoyed" => 5000,
      "wolf" => 999999,
      "husky" => 3000,
      "chihuahua" => 200
    }
    puts "#{customer_name} has requested a #{breed}."
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
  attr_reader :name, :requests, :completed_req



  def initialize(name="Cruel De Villa Puppy Store")
    @name = name
    @requests = []
  end

  def add_request(request)
    @requests << request
  end

  def self.show_requests(request)
    @requests
  end

  def puppy_available(breed)
      puppy_check = puppygarden.puppies.find_all { |x| x.breed == breed }
      if puppy_check.is_nil? == true
        puts "No puppies of #{breed} breed available"
      else
        puppy_check
      end
  end

  def get_name(breed)
  end



end

class PuppyGarden
  attr_reader :name, :puppies, :breed

    def initialize(name = "AMK")
      @name = name
      @puppies = []
    end

    def add_new_puppy(name, age, breed)
      new_pup = Puppy.new(name, age, breed)
      @puppies << new_pup
    end

    def kill_puppy
      @puppies.pop
    end



end
