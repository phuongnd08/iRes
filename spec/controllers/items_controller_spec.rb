require 'spec_helper'

describe ItemsController do

  let(:category) { Category.make! }
  let(:item) { Item.make!(:category => category) }
  let(:valid_attributes) do
    {
      :category_id => category.id
    }
  end


  describe "GET new" do
    it "assigns a new item as @item" do
      get :new, :category_id => category.id
      assigns(:item).should be_a_new(Item)
      assigns(:item).category.should == category
    end
  end

  describe "GET edit" do
    it "assigns the requested item as @item" do
      get :edit, {:id => item.to_param}
      assigns(:item).should eq(item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, {:item => valid_attributes}
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, {:item => valid_attributes}
        assigns(:item).should be_a(Item)
        assigns(:item).should be_persisted
      end

      it "redirects to the category" do
        post :create, {:item => valid_attributes}
        response.should redirect_to(category)
      end
    end

    describe "with invalid params" do
      before do
        Item.any_instance.stub(:save).and_return(false)
        post :create, {:item => {}}
      end

      it "assigns a newly created but unsaved item as @item" do
        assigns(:item).should be_a_new(Item)
      end

      it "re-renders the 'new' template" do
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested item" do
        Item.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => item.to_param, :item => {'these' => 'params'}}
      end

      it "redirects to the category page" do
        put :update, {:id => item.to_param, :item => valid_attributes}
        response.should redirect_to(category)
      end
    end

    describe "with invalid params" do
      it "assigns the item as @item" do
        Item.any_instance.stub(:save).and_return(false)
        put :update, {:id => item.to_param, :item => {}}
        assigns(:item).should eq(item)
      end

      it "re-renders the 'edit' template" do
        Item.any_instance.stub(:save).and_return(false)
        put :update, {:id => item.to_param, :item => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {:id => item.to_param}
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the category page" do
      delete :destroy, {:id => item.to_param}
      response.should redirect_to(category)
    end
  end

end
