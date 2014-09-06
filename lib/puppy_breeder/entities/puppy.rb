#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :name, :age, :breed 
    attr_accessor :price, :availability, :id

    def initialize(name, age, breed)
      @name = name
      @age = age
      @breed = breed
      @price = nil
      @availability = :for_sale
      @id = nil
    end

    # def add(price = nil)
    #   self.status = :for_sale
    #   ForSale.add(self, price)
    #   on_hold = Requests.purchase_orders.find {|x| x.breed == self.breed && x.status == :on_hold}
    #   Requests.hold_to_pending(on_hold) if !on_hold.nil?
    # end 

    def sold!
      @availability = :sold
    end

  end
end