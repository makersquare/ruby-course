class Puppy

  attr_reader :breed, :name, :age

  def initialize(args)
    @breed = args[:breed]
    @name = args[:name]
    @age = args[:age]
  end
end


class Inventory

  attr_reader :po, :inventory

  def initialize
    @inventory = {}
    @po = []
  end

  def puppy_breed_count
    @inventory[:breed].inject(Hash.new(0)){ |sum,elem| sum[elem]+= 1; sum }
  end

  def intake_of_puppies(puppy)
    if @inventory.has_key?(puppy.breed)
      @inventory[puppy.breed][:list] << puppy
    else
      @inventory[puppy.breed] = {price: nil, list: [puppy]}
    end
  end

  def check_inventory(breed)
    @inventory.has_key?(breed)
  end

  def po_list
    @po.map{|x| x}
  end

end



class PurchaseOrder

  attr_reader :customer,:breed

  def initialize(args)
    @customer = args[:customer]
    @breed = args[:breed]
  end

  def add_purchase_order(inventory_object)
    inventory_object.po << self
  end

  def review
    "Order for #{@customer} ~~~~> Breed: #{@breed}"
  end

end

