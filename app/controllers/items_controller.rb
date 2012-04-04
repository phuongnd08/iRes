class ItemsController < ApplicationController
  def new
    @category = Category.find params[:category_id]
    @item = @category.items.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      redirect_to @item.category
    else
      render :action => "new"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to @item.category, notice: 'Item was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to @item.category
  end
end
