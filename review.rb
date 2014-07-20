
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
    
    def skill=(skill)
      @skill = skill
    end
  end

end


class HashProblems
  # # # # # # #
  # Hashes  1 #
  # # # # # # #

  def self.update_top_compartment_item(wardrobe_hash)
    wardrobe_hash["top compartment"][:item] = "fake beard"
  end
end


class ArrayProblems

  # # # # # # #
  # Arrays  1 #
  # # # # # # #

  def self.add_cat_to_array(array)
    array << {cat: "Pogo"}
  end

  # # # # # # #
  # Arrays  2 #
  # # # # # # #

  def self.list_wardrobe_item_sizes(array)
    array.map{ |x| x[:size] }
  end

  # # # # # # #
  # Arrays  3 #
  # # # # # # #

  def self.tell_me_the_weather(array)
    array.map{ |x| "It is #{x}"}
  end

  # # # # # # #
  # Arrays  4 #
  # # # # # # #

  def self.list_my_hats(array)
    array.map{ |x| x[:size] + " " + x[:style] }
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
    "Bob"
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
      @people.each do |person|
        if person[:salary] == salary
          person[:name]
        end
      end
    end
  end

end
