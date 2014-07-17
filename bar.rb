require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  def initialize(name)
    @name=name
    @menu_items=[]
  end
  def add_menu_item(item, price)
    @item=item
    @price=price
    menhash=Hash.new{}
    menhash[item]=price
    @menu_items.push(menhash)
  end
end
