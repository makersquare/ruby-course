#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder

  class PuppyManager

    attr_accessor :puppies_for_sale

    @@puppies_for_sale = []

    #so I need initialize if I never intend to make an object?
    def initialize()
    end

    def self.add_puppy_for_sale(puppy)
      puppies_for_sale.push(puppy)
    end

    def self.remove_puppy_for_sale(puppy)
      puppies_for_sale.delete(puppy)
    end

    

  end
end