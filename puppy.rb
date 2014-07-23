module PuppyMill

  class Puppy
    attr_reader :breed, :name, :age
    def initialize(args)
      @breed = args[:breed]
      @name = args[:name]
      @age = args[:age]
    end
  end

  class Puppies
    @all_pups = {}

    def self.add_pup(puppy)
      pup_breed = @all_pups[puppy.breed]
      @all_pups.has_key?(puppy.breed) ? (pup_breed[:list] << puppy) : (pup_breed = {price: :unknown, list: [puppy]})
    end

    def self.all_pups
      @all_pups
    end

    def self.check_breed(breed)
      @all_pups.has_key?(breed)
    end
  end

  class PurchaseOrder
    attr_reader :customer_name, :breed

    def initialize(args)
      @customer_name = args[:customer_name]
      @breed = args[:breed]
    end

    def review
      "customer: #{customer_name}, puppy breed: #{breed}"
    end

    # def satisfy_order?
    #   PuppyMill::Puppies.check_breed(breed)
    # end

    def accept
      PuppyMill::PurchaseOrders.add_purchase_order(self)
    end
  end

  class PurchaseOrders
    @all_purchase_orders = []

    def self.add_purchase_order(order)
      @all_purchase_orders << order
    end

    def self.view_all
      @all_purchase_orders
    end
  end

end
