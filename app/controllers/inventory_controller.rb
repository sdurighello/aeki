class InventoryController < ApplicationController

  def index
    @inventories = Inventory.all
    authorize! :read, Inventory
  end

end
