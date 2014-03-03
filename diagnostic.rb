
# # # # # # #
# Problem 1 #
# # # # # # #

# TODO: Write a method caled `toggle_oven`

def toggle_oven(x)
  if x == true
     "The oven is now on"
  else
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
  1*7
end

def p1_get_result
  1*7
end


module ClassesAndInstances

  # # # # # # # # # # # #
  # Classes/Instances 1 #
  # # # # # # # # # # # #
  class Animal
    attr_reader :name
    def initialize(name)
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
      animals.push(animal)
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



class ArrayProblems
  # # # # # # #
  # Arrays  1 #
  # # # # # # #

  def self.add_cake_to_array(array)
    # TODO: Complete this method
    array.push 'cake'
  end

  # # # # # # #
  # Arrays  2 #
  # # # # # # #

  def self.uppercase_third_element(array)
    # TODO: Complete this method
    array[2].upcase!
  end

  # # # # # # #
  # Arrays  3 #
  # # # # # # #

  def self.iterate_and_print(array)
    # TODO: Iterate over this array and `puts` each element.
    array.each {|x| puts x}
  end

  # # # # # # #
  # Arrays  4 #
  # # # # # # #

  def self.select_higher(array, min)
    # TODO: Select and return all numbers higher than `min`
    array.select {|x| x > min }
  end

  # # # # # # #
  # Arrays  5 #
  # # # # # # #

  def self.greet_everyone(people)
    # TODO: Select and return all numbers higher than `min`
    people.map {|person| "Hello, #{person}" }
  end
end



class HashProblems
  # # # # # # #
  # Hashes  1 #
  # # # # # # #

  def self.create_empty_hash
    # TODO: Complete this method
    {}
  end

  # # # # # # #
  # Hashes  2 #
  # # # # # # #

  def self.create_veggie_color_hash
    # TODO: Complete this method by returning a hash
    {
      :tomato => 'red',
      :kale => 'green'
    }
  end

  # # # # # # #
  # Hashes  3 #
  # # # # # # #

  def self.update_father_last_name(hash)
    # TODO: Complete this method by writing A SINGLE LINE
    hash["father"]["name"][:last] = 'James XXX'
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
    grocery_lists.each {|list|
      list.each do |item, count|
        puts "#{item}: #{count}"
      end
    }
  end
end
