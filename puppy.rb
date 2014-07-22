class Request
  attr_reader :customer_name, :breed, :status
  attr_accessor :status, :id

  def initialize(customer_name, breed, status = nil)
    @customer_name = customer_name
    @breed = breed
    # breed.downcase.split(" ").join("_").to_sym
    @status = status
    @id = 0
    # @price = {
    #   "german_shepherd" => 300,
    #   "poodle" => 400,
    #   "pomenarian" => 700,
    #   "collie" => 800,
    #   "samoyed" => 5000,
    #   "wolf" => 999999,
    #   "husky" => 3000,
    #   "chihuahua" => 200
    # }
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
  end

  def add_request(customer_name, breed)
    new_req = Request.new(customer_name, breed, status=nil)
    new_req.id = rand(10000) + Time.now.to_i
    @requests << new_req
  end

  def self.show_requests(request)
    @requests
  end

  def puppy_avilable?(breed)
    pup_list = amk.puppies.select { |x| x.breed == breed }
    !pup_list.empty?
  end

  def puppy_available(breed)
    amk = PuppyGarden.new
    puppy_check = amk.puppies.select { |x| x.breed == breed }
    if puppy_check.empty?
      puts "No puppies of #{breed} breed available"
    else
      puppy_check
    end
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
