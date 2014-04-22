

# # # # # # #
# Problem 1 #
# # # # # # #


def toggle_oven(switch_status)
  if switch_status == true
    "The oven is now on"
  elsif switch_status == false
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
  multiply(7,1)
end



module ClassesAndInstances

  # # # # # # # # # # # #
  # Classes/Instances 1 #
  # # # # # # # # # # # #
  class Animal
    attr_reader :name
    def initialize(name)
      # TODO: Set name
      @name = name
    end
  end

  # # # # # # # # # # # #
  # Classes/Instances 2 #
  # # # # # # # # # # # #

  class Zoo
    attr_reader :animals
    def initialize
      @animals = []
    end

    # TODO: Write a method `adopt` that takes one paramater `animal`
    # and adds it to its animals array
    def adopt(animal)
      @animals << animal
    end
  end

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

    # def size
    #   @size
    # end
  end
end



module GettersSetters

  # # # # # # # # # # #
  # Getters/Setters 1 #
  # # # # # # # # # # #
  class Box
    def initialize
      @secret = 50
    end

    def secret
      @secret
    end

    def secret=(value)
      @secret = value
    end
    # TODO: Write getter and setter methods for secret
  end

  # # # # # # # # # # #
  # Getters/Setters 2 #
  # # # # # # # # # # #
  class Person

    def initialize(name, age)
      @name = name
      @age = age
    end
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # TODO: Refator the following to use attr_[reader|writer|accessible] shortcuts
    # NOTE: Don't provide any more access than necessary.
    #       For example, don't use attr_accessible when all you really need is attr_writer
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    attr_reader :age
    attr_writer :secret
    attr_accessor :name

    # def age
    #   @age
    # end

    # def secret=(value)
    #   @secret = value
    # end

    # def name
    #   @name
    # end

    # def name=(value)
    #   @name = value
    # end
  end
end



class ArrayProblems
  # # # # # # #
  # Arrays  1 #
  # # # # # # #

  def self.add_cake_to_array(array)
    # TODO: Complete this method
    # desserts = ['apple', 'ice cream']
    # ArrayProblems.add_cake_to_array(desserts)
    # expect(desserts).to eq ['apple', 'ice cream', 'cake']

    array << "cake"
  end

  # # # # # # #
  # Arrays  2 #
  # # # # # # #

  def self.uppercase_third_element(array)
    # TODO: Complete this method
    # fruits = ['radish', 'rutabaga', 'orange', 'apple']
    #   ArrayProblems.uppercase_third_element(fruits)
    #   expect(fruits).to eq ['radish', 'rutabaga', 'ORANGE', 'apple']

    #   fruits = ['pear', 'banana', 'grape']
    #   ArrayProblems.uppercase_third_element(fruits)
    #   expect(fruits).to eq ['pear', 'banana', 'GRAPE']
    array[2].upcase!
  end

  # # # # # # #
  # Arrays  3 #
  # # # # # # #

  def self.iterate_and_print(array)
    # TODO: Iterate over this array and `puts` each element.
     # Take 1
      # expect(ArrayProblems).to receive(:puts).with('top')
      # expect(ArrayProblems).to receive(:puts).with('bowler')
      # expect(ArrayProblems).to receive(:puts).with('baseball')

      # hats = ['top', 'bowler', 'baseball']
      # ArrayProblems.iterate_and_print(hats)
      array.each { |element| puts element }
  end

  # # # # # # #
  # Arrays  4 #
  # # # # # # #

  def self.select_higher(array, min)
    # TODO: Select and return all numbers higher than `min`
    # numbers = [33, 11, 5, 55, 67, 8, 95, 0, 110]

    #   result = ArrayProblems.select_higher(numbers, 55)
    #   expect(result).to include(67, 95, 110)
    range_array = array.select {|number| number > min}
  end

  # # # # # # #
  # Arrays  5 #
  # # # # # # #

  def self.greet_everyone(people)
    # TODO: Select and return all numbers higher than `min`
      #   xyou "know how to use the map method" do
      # people = ['Alice', 'Bob']

      # result = ArrayProblems.greet_everyone(people)
      # expect(result).to include("Hello, Alice", "Hello, Bob")

      # expect(@source).to include_code(:map).in_class_method(:ArrayProblems, :greet_everyone)
    end
  end
end



class HashProblems
  # # # # # # #
  # Hashes  1 #
  # # # # # # #

  def self.create_empty_hash
    # TODO: Complete this method
  end

  # # # # # # #
  # Hashes  2 #
  # # # # # # #

  def self.create_veggie_color_hash
    # TODO: Complete this method by returning a hash
  end

  # # # # # # #
  # Hashes  3 #
  # # # # # # #

  def self.update_father_last_name(hash)
    # TODO: Complete this method by writing A SINGLE LINE
  end
end



class ArraysAndHashes
  # # # # # # # # # # #
  # Arrays & Hashes 1 #
  # # # # # # # # # # #

  def self.iterate_and_print(grocery_lists)
    # TODO: Iterate over this array and `puts` each key and value
    # Example: if array is [{ egg: 12 }, { milk: 1 }],
    #          then `puts` both "egg: 12" and "milk: 1"
  end
end
