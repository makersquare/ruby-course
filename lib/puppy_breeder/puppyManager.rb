#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder

  class PuppyManager

    @@puppies_for_sale = []

    def self.add_puppy_for_sale(puppy)
      @@puppies_for_sale.push(puppy)
    end

    def self.remove_puppy_for_sale(puppy)
      @@puppies_for_sale.delete(puppy)
    end

    def self.puppies_for_sale()
      @@puppies_for_sale
    end

    def self.clear_puppies()
      @@puppies_for_sale = []
    end

    def self.find_match(purchase_request)
      desired_breed = purchase_request.breed
      puppies = puppies_for_sale
      match = puppies.find { |pup| pup.breed == desired_breed }
    end

  end
end