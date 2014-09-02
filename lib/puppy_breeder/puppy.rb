#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_accessor :cost, :sold_status
    attr_reader :breed, :name, :age, :puppy_id
    @@puppy_counter = 0
    @@breed_costs = {
      "French Bulldog" => 1500,
      "Shih Tzu" => 500,
      "Boxer" => 750,
      "Golden Retriever" => 2000,
      "Dachshund" => 400
    }

    def initialize(breed, name, age, sold_status="Available")
      @breed = breed
      @name = name
      @age = age
      @cost = @@breed_costs[breed]
      @sold_status = sold_status
      @@puppy_counter += 1
      @puppy_id = @@puppy_counter
    end

  end
end