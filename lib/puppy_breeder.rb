require 'pry-byebug'
# we initialize the module here to use in our other files
module PuppyBreeder

  @@puppies_hash = Hash.new do |hash, key|
    key = key.to_sym

    if hash.has_key?(key)
      dog_list = hash[key][:dog_list]
    else
      dog_list = []
    end

    hash[key] = {
      :price => @@puppy_price[key],
      :dog_list => dog_list
    } 
  end

  @@puppy_price = {
    :boxer => 1000,
    :schnauzer => 1500,
    :pug => 50,
    :yorkshire_terrier => 500
  }

  @@purchase_requests_open = {}
  @@purchase_requests_completed = {}

  @@purchase_id = 0

  def self.input_purchase(customer,breed)
    self.review_purchase(PurchaseRequest.new(customer,breed))
  end
  
  def self.review_purchase(purchase)
    # either accept or reject
    # based on whether we have that breed
  end

  def self.accept_purchase(purchase)
    @@purchase_id += 1
    @@purchase_requests_open[@@purchase_id] = purchase
    @@purchase_id
  end

  def self.reject_purchase(purchase)
    "Your purchase request can not be filled at this time."
  end

  def self.add_puppy(puppy)
    @@puppies_hash[puppy.breed][:dog_list] << puppy
  end

  def self.deliver_puppy(purchase_id)
    purchase = @@purchase_requests_open.delete(purchase_id)
    @@purchase_requests_completed[purchase_id] = purchase
    delivered = @@puppies_hash[purchase.breed.to_sym][:dog_list].pop
    delivered
  end

  def self.dogs_available
    return @@puppies_hash
  end

  def self.price
    return @@puppy_price
  end

  def self.open_purchase_requests
    @@purchase_requests_open.values
  end

  def self.completed_purchase_requests
    @@purchase_requests_completed.values
  end

end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'

