#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :name, :breed, :id
    attr_accessor :status
    
    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @breed = params[:breed]
      @status = params[:status] || 'available'
    end
  end
end