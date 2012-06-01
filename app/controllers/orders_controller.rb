class OrdersController < ApplicationController
  before_filter :load_order, :except => [:index, :new, :create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  def show
    respond_to do |format|
      format.xls do
        Spreadsheet::Workbook.new.tap do |book|
          book.create_worksheet.tap do |sheet|
            row = 0
            sheet[row, 0] = @order.name
            sheet[row, 1] = @order.created_on
            sheet[row += 1, 0] = t("order_items.category")
            sheet[row, 1] = t("order_items.item")
            sheet[row, 2] = t("order_items.price")
            @order.order_items.each_with_index do |order_item, index|
              sheet[row += 1, 0] = order_item.item.category.name
              sheet[row, 1] = order_item.item_name
              sheet[row, 2] = order_item.price
            end
            sheet[row += 1, 0] = t("order.total_price")
            sheet[row, 2] = @order.total_price
          end

          StringIO.new.tap do |io|
            book.write io
            io.seek 0
            send_data io.read, content_type: 'application/vnd.ms-excel', filename: "#{@order.id}.xls"
          end
        end
      end
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new(:table_number => params[:table_number])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to "/waiter", notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @order.update_attributes(params[:order])
      redirect_to "/waiter", notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @order.destroy
    redirect_to "/waiter"
  end

  def mark_ready
    @order.update_attribute(:ready, true)
    render :nothing => true
  end

  def mark_paid
    @order.update_attribute(:paid, true)
    render :nothing => true
  end

  def mark_served
    @order.update_attribute(:served, true)
    render :nothing => true
  end

  private
  def load_order
    @order = Order.find params[:id]
  end
end
