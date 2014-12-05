#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :customer, :breed
    attr_accessor :status

    def initialize(params)
      @customer = params[:customer]
      @breed = params[:breed]
      @status = 'pending'
    end
  end
end