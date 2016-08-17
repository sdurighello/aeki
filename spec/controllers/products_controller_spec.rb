require "rails_helper"

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
end
