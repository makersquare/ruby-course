class ItemsController < ApplicationController
  def index
    @items = DoubleDog.db.all_items
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
