class OrdersController < ApplicationController
  def index
    @orders = DoubleDog.db.all_orders
  end

  def create
  end
end
