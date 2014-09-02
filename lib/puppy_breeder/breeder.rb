module PuppyBreeder

 class Breeder

  attr_accessor :name
  
  def initialize(name)
    @name=name       
    @breed_types = {
      "doberman" => 
        :price => 100,
        :list => []
      }
      
      "pitbull" => {
        :price => 200,
        :list => []
      }
        
      "american eskimo" => {
        :price => 100,
        :list => []
      } 
      "unknown" => {
        :price => 25,
        :list => []
      }   
    }
  end

  def for_sale(puppy)
    @breed_types[puppy.breed][:list] << puppy
  end

end

end