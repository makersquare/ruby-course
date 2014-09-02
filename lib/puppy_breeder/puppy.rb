#Refer to this class as PuppyBreeder::Puppy
require 'pry-byebug'
module PuppyBreeder
  class Puppy
    @@counter = 1
    attr_accessor :status, :breed, :id, :name

    def initialize(breed='mix',name="spot")
      @id = @@counter
      @@counter +=1
      @status = 'available'
      @breed = breed
      @name = name
    end

  end

  class DogShelter
    @@costhash={'pitbull'=>300,'golden retrierver'=>400,'mix'=>200,'ultra rare breed'=>1000,'lab'=>500}
    @@counter =1
    @@doglist = {}
    @@available_dogs=[]
    @@adopted_dogs = []

    def self.add_dog(dog)
      @@doglist[@@counter] = dog
      @@available_dogs << dog
      @@counter += 1
    end

    def self.create_dog(breed)
      dog = Puppy.new(breed)
      add_dog(dog)
    end

    def self.cost?(id_number)
      @@costhash[@@doglist[id_number].breed]
    end

    def self.available_by_breed(breed,name='spot')
      result = @@available_dogs.select {|dog| dog.breed == breed}
      result
    end

    def self.doglist
      @@doglist      
    end

    def self.adoption(dog_id)
      dog = doglist[dog_id]
      @@adopted_dogs.push(dog)
      @@available_dogs.delete(dog)
    end

    def self.fill_dog_order(request_id,dog_id)
      puts "Request #{request_id} for #{PuppyBreeder::RequestRepository.breed_requested(request_id)} has been filled. Dog #{dog_id}, #{@@doglist[dog_id].name} has been assigned."
      self.adoption(dog_id)
      RequestRepository.complete_request(request_id)
      return doglist[dog_id].name
    end

  end
end