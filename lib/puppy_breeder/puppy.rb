#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :name, :breed, :status
    
    def initialize(params)
      @name = params[:name]
      @breed = params[:breed]
      @status = 'available'
    end
  end
end