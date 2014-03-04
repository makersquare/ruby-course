
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
  end

end


class HashProblems
  # # # # # # #
  # Hashes  1 #
  # # # # # # #

  def self.update_top_compartment_item(wardrobe_hash)
    # TODO: Complete this method by writing A SINGLE LINE
  end

end

class ArrayProblems

  # # # # # # #
  # Arrays  1 #
  # # # # # # #

  def self.add_cat_to_array(array)
    # TODO: Complete this method
  end

  # # # # # # #
  # Arrays  2 #
  # # # # # # #

  def self.list_wardrobe_item_sizes(array)
    # TODO: Use the map method to create an array of wardrobe item sizes
  end

  # # # # # # #
  # Arrays  3 #
  # # # # # # #

  def self.tell_me_the_weather(array)
    # TODO: Use the map method to create an array of weather descriptions
  end

  # # # # # # #
  # Arrays  4 #
  # # # # # # #
  
  def self.list_my_hats(array)
    # TODO: Use the map method to create an array of sized hats
  end
end

class ImplicitAndExplicitReturns

  def self.confirm_if_include(array, search_item)
    # TODO: make this method output the string in the if statement if the search_item exists in the array
    array.each do |elem|
      if elem == search_item
        "The array contains the search item"
      end
    end
  end

end

