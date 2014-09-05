require 'pry-byebug'
#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyPalace
  class PurchaseRequest
    attr_accessor :breed, :status, :id

    def initialize(breed,status='pending')
      @breed = breed
      @status = status
      @id = nil
    end
  end
end