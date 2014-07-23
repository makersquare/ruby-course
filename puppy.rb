class Request
  attr_reader :customer_name, :breed
  attr_accessor :status, :id

  def initialize(customer_name, breed, status = "pending")
    @customer_name = customer_name
    @breed = breed
    # @breed.downcase.split(" ").join("_").to_sym
    @status = status
    @id = 0
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
  attr_reader :name, :requests, :completed_req, :amk
  attr_accessor :status

  def initialize(name="Cruel De Villa Puppy Store")
    @name = name
    @requests = []
    @price = {
      :german_shepherd => 300,
      :poodle => 400,
      :pomenarian => 700,
      :collie => 800,
      :samoyed => 5000,
      :wolf => 999999,
      :husky => 3000,
      :collie => 5000
    }
    @amk = PuppyGarden.new
  end

  def add_request(customer_name, breed)
    new_req = Request.new(customer_name, breed, status="pending")
    new_req.id = rand(10000) + Time.now.to_i
    @requests << new_req
    puts "#{customer_name} has requested #{breed}. Your purchase request id is #{new_req.id}."

    # Auto-change new requests to "on-hold" status if no breed
    # of desire is available (empty array)
    if @amk.puppies.select { |x| x.breed == breed } == []
      y = @requests.find { |x| x.id == new_req.id }
      y.status = "on-hold"
    end

  end

  def show_requests
    @requests.select { |x| x.status == "pending" || x.status == "accepted" } 
  end

  def change_purchase_request_status(id)
    index = @requests.find_index { |x| x.id == id}
    if index != nil && @requests[index].status == "pending"
      @requests[index].status = "accepted"
      puts "Purchase request for #{@requests[index].customer_name} has been changed to 'accepted'."
      true
    elsif index != nil && @requests[index].status == "on-hold"
      @request[index].status = "pending"
    else
      "No purchase request for ID #{id}."
    end
  end

  def puppy_avilable?(breed)
    pup_list = @amk.puppies.select { |x| x.breed == breed }
    !pup_list.empty?
  end

  def puppy_available(breed)
    puppy_check = @amk.puppies.select { |x| x.breed == breed }
    if puppy_check.empty?
      puts "No puppies of #{breed} breed available"
      false
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
