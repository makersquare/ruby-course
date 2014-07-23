
# # # # # # #
# Problem 1 #
# # # # # # #

module GettersSetters

  # # # # # #
  # Setters #
  # # # # # #

  class Doctor
    attr_reader :skill

    def initialize
      @skill = "bedside manners"
    end
    # TODO: Write a setter method for @skill
    def skill= (skill)
      @skill = skill
    end
  end

end


class HashProblems
  # # # # # # #
  # Hashes  1 #
  # # # # # # #

  def self.update_top_compartment_item(wardrobe_hash)
    # TODO: Complete this method by writing A SINGLE LINE
    wardrobe_hash["top compartment"] = {:item => "fake beard"}
  end

end


class ArrayProblems

  # # # # # # #
  # Arrays  1 #
  # # # # # # #

  def self.add_cat_to_array(array)
    # TODO: Complete this method
    array<<{:cat => 'Pogo'}
  end

  # # # # # # #
  # Arrays  2 #
  # # # # # # #

  def self.list_wardrobe_item_sizes(array)
    # TODO: Use the map method to create an array of wardrobe item sizes
    array.map { |x| x[:size] }
  end

  # # # # # # #
  # Arrays  3 #
  # # # # # # #

  def self.tell_me_the_weather(array)
    # TODO: Use the map method to create an array of weather descriptions
    array.map { |x| "It is #{x}" }
  end

  # # # # # # #
  # Arrays  4 #
  # # # # # # #

  def self.list_my_hats(array)
    # TODO: Use the map method to create an array of sized hats
    array.map { |x| "#{x[:size]} #{x[:style]}"}
  end
end


class MethodReturns

  def self.include?(array, search_item)
    # TODO: Make this method return true or false depending whether
    #       or not the search_item exists in the array.
    array.each do |elem|
      if elem == search_item
        return true
      end
    end
    false
  end

  def self.get_name
     puts = "Bob"
  end

end


module Scopes

  class Person
    def jump(height)
      @jump_height = height
      "I can jump #{@jump_height} inches!"
    end

    def last_jump_height
      "I last jumped #{@jump_height} inches."
    end
  end

  class Finder
    def initialize(people)
      @people = people
    end

    def find_first(salary)
      @found = nil
      @people.each do |person|
        if person[:salary] == salary
          @found = person
        end
      end

      @found
    end
  end

end
