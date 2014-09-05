module PAWS
  
  class Puppy
  
    attr_reader :breed, :name, :age_in_days, :status
    attr_accessor :id 
    
    def initialize(breed,name=nil,age_in_days=nil,status=:available, id=nil)
      @breed = breed
      @name = name
      @age_in_days = age_in_days
      @status = status
      @id = id
    end
  
    def available?
      @status == :available
    end

    def available!
      @status = :available
    end

    def adopted?
      @status == :adopted
    end
    
    def adopted!
      @status = :adopted
    end

  end

end