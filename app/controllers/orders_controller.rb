class OrdersController < ApplicationController
  before_filter :load_order, :except => [:index, :new, :create]

  class << self
    MAX_PRINT_SLOT = 10
    attr_accessor :print_slot
    def next_print_slot
      self.print_slot = print_slot.to_i + 1
      self.print_slot = 1 if print_slot > MAX_PRINT_SLOT
      print_slot
    end
  end

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

  def change_state
    if params[:state]
      @order.update_attribute(params[:state], true)
    end
    render :text => "OK"
  end

  def print
    Rails.root.join("tmp/#{Time.now.to_i}-#{rand(1000)}.pdf").tap do |path|
      @order.write_pdf_file(path.to_s)
      Printer.print(path.to_s)
      path.delete
    end

    render :text => "OK"
  end

  private
  def load_order
    @order = Order.find params[:id]
  end
end
