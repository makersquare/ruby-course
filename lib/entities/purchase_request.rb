#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :customer, :breed, :id
    attr_accessor :status, :puppy

    def initialize(params)
      @id = params[:id]
      @customer = params[:customer]
      @breed = params[:breed]
      @status = params[:status] || 'pending'
      @puppy = params[:puppy] || nil
    end
  end
end