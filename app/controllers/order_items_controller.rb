class OrderItemsController < ApplicationController
  def change_state
    if params[:state]
      OrderItem.find(params[:id]).update_attribute(params[:state], true)
    end
    render :nothing => true
  end
end
