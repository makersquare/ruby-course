module PuppyBreeder

class Breeder

  attr_reader :name
  attr_accessor :breed_types
  
  def initialize(name)
    @name=name       
    @breed_types = {
      "doberman" => {
        :price => 100,
        :list => []
      },
      
      "pitbull" => {
        :price => 200,
        :list => []
      },
        
      "american eskimo" => {
        :price => 100,
        :list => []
      },  
    }
  end

  def for_sale(puppy)
    if @breed_types.keys.include?(puppy.breed) 
    return @breed_types[puppy.breed][:list] << puppy
    else
      @breed_types[puppy.breed] = 
        {
        :price => 100, 
        :list => []
        }
      @breed_types[puppy.breed][:list] << puppy
    end
  end

end

end