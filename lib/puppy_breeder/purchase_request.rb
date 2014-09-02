#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
      attr_accessor :status
      attr_reader :customer, :breed, :id, :price

      @@count = 0

      def initialize(customer, breed, status='pending')
        @customer = customer
        @breed = breed
        @@count += 1
        @id = @@count
        @price = PuppyBreeder::Data.cost[breed]
        @status = status
        (PuppyBreeder::Data.allrequests ||= []) << self
      end
  end
end