#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :name, :breed, :age
    attr_accessor :price, :status, :buyer
    def initialize(name, breed, age=0, status='available', price=nil, buyer=nil)
      @name = name
      @breed = breed
      @age = age
      @status = status
      @price = price
      @buyer = buyer
    end
  end

  class Breeder
    attr_reader :name, :puppies, :price_list, :bank_account, :hold
    attr_accessor :purchase_requests

    def initialize(name)
      @name = name
      @bank_account = 0
      @puppies = []
      @hold = {'mut' => []}
      @price_list = {'mut' => 50}
      @hold_counter = 0
    end


    def new_puppy(puppy)
      price_assignment(puppy)
      @puppies << puppy
      if @hold[puppy.breed].length > 0
        self.pending(puppy.breed, @hold[puppy.breed].first[1])
        @hold[puppy.breed].shift
      end
    end

    def update_price(update_breed, new_price)
      @price_list[update_breed] = new_price
      @puppies.each {|pup| pup.price = new_price if pup.breed == update_breed}
      @hold[update_breed] = []
    end

    def pending(breed, customer)
      dog = @puppies.select {|pup| pup if pup.breed == breed && pup.status == 'available'}
      if dog.length >= 1
        dog = dog[rand(dog.length)]
        dog.status = "pending purchase by #{customer.name}"
        dog.buyer = customer
      else 
        @hold[breed] << [@hold_counter, customer]
        @hold_counter += 1
      end
    end



    def sell_dog(dog)
      status_arr = dog.status.split
      if status_arr.first == 'pending'
        @bank_account += dog.price
        dog.status = "sold to #{dog.buyer.name}"
      end
    end

    def view_sales
      @puppies.select {|pup| pup if pup.status.split.first == 'sold'}
    end

    private
    
    def price_assignment(puppy)
      puppy.price = @price_list[puppy.breed]
    end

  end
end


