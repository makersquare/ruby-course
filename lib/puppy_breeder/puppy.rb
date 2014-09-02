#Refer to this class as PuppyBreeder::Puppy
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
    @@costhash={'pitbull'=>300,'golden retrierver'=>400,'mix'=>200,'ultra rare breed'=>1000}
    @@counter =1
    @@doglist = {}
    @@available_dogs=[]
    @@adopted_dogs = []

    def self.add_dog(breed)
      dog = Puppy.new(breed)
      @@doglist[@@counter] = dog
      @@available_dogs << dog
      @@counter += 1
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

    def adoption(dog_id)
      dog = @@dog_list[dog_id]
      @@adopted_dogs.push(dog)
      @@available_dogs.delete(dog)
    end

    def self.fill_dog_order(request_id,dog_id)
      puts "#{request_id} for #{request_id.breed_requested} has been filled. Dog #{dog_id}, #{@@doglist[dog_id].name} has been assigned."
      self.adoption(dog_id)
      RequestRepository.complete_request(request_id)
    end

  end
end