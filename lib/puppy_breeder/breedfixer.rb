#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  
  class BreedFixer
  
    def self.symbol(breed_string)
      breed_string.downcase.split.join("_").to_sym
    end

    def self.string(breed_symbol)
      breed_symbol.to_s.split("_").join(" ").capitalize
    end

  end

end