require 'pry-byebug'
# we initialize the module here to use in our other files
module PuppyBreeder

  @@puppies_hash = {}

  @@puppy_price = {
    :boxer => 1000,
    :schnauzer => 1500,
    :pug => 50,
    :yorkshire_terrier => 500
  }

  @@open_purchase_requests = {}

  @@completed_purchase_requests = {}

  @@purchase_id = 0

  def self.input_purchase(customer,breed)
    self.review_purchase(PurchaseRequest.new(customer,breed))
  end
  
  def self.review_purchase(purchase)
    key = purchase.breed.to_sym
    if @@puppies_hash.has_key?(key)
      self.accept_purchase(purchase)
    else
      self.reject_purchase(purchase)
    end
  end

  def self.accept_purchase(purchase)
    @@purchase_id += 1
    @@open_purchase_requests[@@purchase_id] = purchase
    purchase.id = @@purchase_id
  end

  def self.reject_purchase(purchase)
    "Your purchase request can not be filled at this time."
  end

  def self.add_puppy(puppy)
    key = puppy.breed.to_sym

    if @@puppies_hash.has_key?(key)
      @@puppies_hash[key][:dog_list] << puppy
    else
      @@puppies_hash[key] = {
        :price => @@puppy_price[key],
        :dog_list => [puppy]
      }
    end
  end

  def self.deliver_puppy(purchase)
    purchase = @@open_purchase_requests.delete(purchase.id)
    @@completed_purchase_requests[purchase.id] = purchase
    @@puppies_hash[purchase.breed.to_sym][:dog_list].pop
  end

  def self.dogs_available
    return @@puppies_hash
  end

  def self.price
    return @@puppy_price
  end

  def self.open_purchase_requests
    @@open_purchase_requests.values
  end

  def self.completed_purchase_requests
    @@completed_purchase_requests.values
  end

end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'

