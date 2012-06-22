require 'spec_helper'

describe OrdersController do

  let!(:order) { Order.make! }
  let(:valid_attributes) { { :table_number => 1 } }

  describe "GET index" do
    it "assigns all orders as @orders" do
      get :index
      assigns(:orders).should eq([order])
    end
  end

  describe "GET show" do
    let(:order) { Order.make!(:order_items => order_items) }
    let(:category) { Category.make! }
    let(:items) { 2.times.map { |index| Item.make!(:category => category, :name => "item ##{index + 1}") } }
    let(:order_items) { 2.times.map { |index| OrderItem.new(:item => items[index], :price => (index + 1)*10000) } }

    context "excel format" do
      it "returns an excel file containing order details" do
        get :show, :id => order.id, :format => :xls
        io = StringIO.new
        io.write(response.body)
        io.seek 0
        book = Spreadsheet.open(io)
        rows = book.worksheets.first.map { |row| row.join(',') }.join("\n")
        rows.should include(order.name)
        rows.should include(category.name)
        items.each { |item| rows.should include(item.name) }
        order_items.each { |order_item| rows.should include(order_item.price.to_s) }
        rows.should include(order_items.map(&:price).sum.to_s)
      end
    end
  end

  describe "GET new" do
    it "assigns a new order as @order" do
      get :new
      assigns(:order).should be_a_new(Order)
    end
  end

  describe "GET edit" do
    it "assigns the requested order as @order" do
      get :edit, {:id => order.to_param}
      assigns(:order).should eq(order)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Order" do
        expect {
          post :create, {:order => valid_attributes}
        }.to change(Order, :count).by(1)
      end

      it "redirects to the /waiter" do
        post :create, {:order => valid_attributes}
        response.should redirect_to("/waiter")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved order as @order" do
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        post :create, {:order => {}}
        assigns(:order).should be_a_new(Order)
      end

      it "re-renders the 'new' template" do
        Order.any_instance.stub(:save).and_return(false)
        post :create, {:order => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested order" do
        Order.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => order.to_param, :order => {'these' => 'params'}}
      end

      it "redirects to /waiter" do
        put :update, {:id => order.to_param, :order => valid_attributes}
        response.should redirect_to("/waiter")
      end
    end

    describe "with invalid params" do
      it "assigns the order as @order" do
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => {}}
        assigns(:order).should eq(order)
      end

      it "re-renders the 'edit' template" do
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "PUT change_state" do
    let(:order) { Order.make!(:with_order_items) }
    [:ready, :served, :paid].each do |state|
      it "change the order #{state} to true" do
        order.send(state.to_sym).should be_false
        put :change_state, :id => order.id, :state => state
        order.reload.send(state.to_sym).should be_true
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested order" do
      expect {
        delete :destroy, {:id => order.to_param}
      }.to change(Order, :count).by(-1)
    end

    it "redirects to waiter page" do
      delete :destroy, {:id => order.to_param}
      response.should redirect_to(waiter_url)
    end
  end
end
