require "rails_helper"
require "spec_helper"

describe ProductsController do
  let!(:product) { create(:product) }

  describe "GET index" do
    it "assigns @products and renders the index template" do
      get :index

      expect(assigns(:products)).to eq([product])
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @product and renders the show template" do
      get :show, id: product.to_param

      expect(assigns(:product)).to eq(product)
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "assigns a new product as @product and renders the new template" do
      get :new

      expect(assigns(:product)).to be_a_new(Product)
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    before do
      get :edit, id: product.to_param
    end

    it "assigns the requested product as @product" do
      expect(assigns(:product)).to eq(product)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
end
