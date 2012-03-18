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

  def show; end

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
