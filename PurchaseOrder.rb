class PurchaseOrder

  attr_reader :customer,:breed

  def initialize(args)
    @customer = args[:customer]
    @breed = args[:breed]
  end

  def add_purchase_order_to(inventory)
    inventory.po << self
  end

  def review
    "Order for #{@customer} ~~~~> Breed: #{@breed}"
  end

end