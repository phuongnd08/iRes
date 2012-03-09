class OrderItemsController < ApplicationController
  def mark_ready
    OrderItem.find(params[:id]).update_attribute(:ready, true)
    render :nothing => true
  end
end
