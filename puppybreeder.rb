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
    @inventory = []
    @po = []
  end

  def puppy_list
    @inventory.map{ |x| x.breed }.inject(Hash.new(0)){ |sum,elem| sum[elem]+= 1; sum }
  end

  def intake(args)
    @@inventory << Puppy.new(args)
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

  def add(inventory)
    inventory.po << self
  end

  def review
    "Order for #{@customer} ~~~~> Breed: #{@breed}"
  end

end

