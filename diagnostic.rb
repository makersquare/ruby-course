
# # # # # # #
# Problem 1 #
# # # # # # #

# TODO: Write a method caled `toggle_oven`
def toggle_oven(status)
  if status == true
    "The oven is now on"
elsif status == false
  "The oven is now off"
  end
  end

# # # # # # #
# Problem 2 #
# # # # # # #

def multiply(x, y)
  result = x * y
end

def give_me_seven
  multiply(7, 1)
end

module ClassesAndInstances

  # # # # # # # # # # # #
  # Classes/Instances 1 #
  # # # # # # # # # # # #
  class Animal
    attr_reader :name
    attr_writer :name
    def initialize(name)
      @name = name
      # TODO: Set name
    end
  end
animal = Animal.new('bird')
animal.name

  # # # # # # # # # # # #
  # Classes/Instances 2 #
  # # # # # # # # # # # #

  class Zoo
    attr_reader :animals
    def initialize
      @animals = []
    end

    def adopt(animal)
      @animals << animal
    end

    # TODO: Write a method `adopt` that takes one paramater `animal`
    # and adds it to its animals array
  end
  lion = ClassesAndInstances::Animal.new('lion')
  tiger = ClassesAndInstances::Animal.new('tiger')
  liger = ClassesAndInstances::Animal.new('liger')

  zoo = ClassesAndInstances::Zoo.new
  zoo.adopt(lion)
  zoo.adopt(tiger)

  # # # # # # # # # # # #
  # Classes/Instances 3 #
  # # # # # # # # # # # #
  class Plant
    attr_accessor :size
    # TODO: Fix incorrect use of local and instance variables
    def initialize(initial_size)
      @size = initial_size
    end

    def grow
      @size = @size + 1
    end
  end
  plant = ClassesAndInstances::Plant.new(1)
  plant.grow
  plant.grow
  plant.grow
end



module GettersSetters

  # # # # # # # # # # #
  # Getters/Setters 1 #
  # # # # # # # # # # #
  class Box
    def initialize
      @secret = 50
    end
    # TODO: Write getter and setter methods for secret
  end

  # # # # # # # # # # #
  # Getters/Setters 2 #
  # # # # # # # # # # #
  class Person
    attr_reader :age, :name
    attr_writer :secret, :name

    def initialize(name, age)
      @name = name
      @age = age
    end
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # TODO: Refator the following to use attr_[reader|writer|accessible] shortcuts
    # NOTE: Don't provide any more access than necessary.
    #       For example, don't use attr_accessible when all you really need is attr_writer
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    def age
      @age
    end

    def secret=(value)
      @secret = value
    end

    def name
      @name
    end

    def name=(value)
      @name = value
    end
  end
end
box = GettersSetters::Box.new
box.secret



class ArrayProblems
  # # # # # # #
  # Arrays  1 #
  # # # # # # #

  def self.add_cake_to_array(array)
    # TODO: Complete this method
  end

  # # # # # # #
  # Arrays  2 #
  # # # # # # #

  def self.uppercase_third_element(array)
    # TODO: Complete this method
  end

  # # # # # # #
  # Arrays  3 #
  # # # # # # #

  def self.iterate_and_print(array)
    # TODO: Iterate over this array and `puts` each element.
  end

  # # # # # # #
  # Arrays  4 #
  # # # # # # #

  def self.select_higher(array, min)
    # TODO: Select and return all numbers higher than `min`
  end

  # # # # # # #
  # Arrays  5 #
  # # # # # # #

  def self.greet_everyone(people)
    # TODO: Select and return all numbers higher than `min`
    people.map do |name|
      "Hello {name}"
  end
end



class HashProblems
  # # # # # # #
  # Hashes  1 #
  # # # # # # #

  def self.create_empty_hash
    # TODO: Complete this method
    my_hash = {}
  end

  # # # # # # #
  # Hashes  2 #
  # # # # # # #

  def self.create_veggie_color_hash
    # TODO: Complete this method by returning a hash
    {tomato: "red", kale: "green"}
  end

  # # # # # # #
  # Hashes  3 #
  # # # # # # #

  def self.update_father_last_name(hash)
    # TODO: Complete this method by writing A SINGLE LINE
    hash["father"]["name"][:last] = "James XXX"
  end
end

class ArraysAndHashes
  # # # # # # # # # # #
  # Arrays & Hashes 1 #
  # # # # # # # # # # #
  def ArrayAndHashes

  end

  def self.iterate_and_print(grocery_lists)
    # TODO: Iterate over this array and `puts` each key and value
    # Example: if array is [{ egg: 12 }, { milk: 1 }],
    #          then `puts` both "egg: 12" and "milk: 1"
    grocery_lists.each do |x|
      x.each do |item, num|
        puts "{item}: {num}"
      end
    end
  end
end
end
