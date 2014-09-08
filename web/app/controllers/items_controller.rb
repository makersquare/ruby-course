class ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = DoubleDog.db.all_items
  end

  def create
    tx_params = item_params.merge :session_id => $session_id
    tx_params[:price] = tx_params[:price].to_f
    result = DoubleDog::CreateItem.new.run(tx_params)

    if result[:success?]
      redirect_to item_path(result[:item].id)
    else
      @items = DoubleDog.db.all_items
      @item = DoubleDog::Item.new(nil, tx_params[:name], tx_params[:price])
      @error = result[:error]
      render 'index'
    end
  end

  def show
    @item = DoubleDog.db.get_item  params[:id].to_i
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :price)
  end

  def authenticate_admin!
    if current_user.nil? || !current_user.admin?
      redirect_to root_path
      return false
    end
  end
end
