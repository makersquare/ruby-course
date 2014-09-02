#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :status, :id_count, :id_num

    @@id_count = 0

    def initialize(breed,status='pending',id_num=@id_count)
      @breed = breed
      @status = status
      @id_num = @@id_count
      @@id_count += 1
    end
  end
end