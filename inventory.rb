class Inventory

  attr_reader :po, :inventory

  def initialize
    @inventory = {}
    @po = []
  end

  def puppy_breed_count
    @inventory.inject(Hash.new(0)){ |sum,elem| sum[elem]+= 1; sum }
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