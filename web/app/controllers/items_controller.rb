class ItemsController < ApplicationController
  before_action :authenticate_admin!

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

  private

  def authenticate_admin!
    if current_user.nil? || !current_user.admin?
      redirect_to root_path
      return false
    end
  end
end
