require "rails_helper"

describe ProductsController do
  describe "GET index" do
    it "assigns @products and renders the index template" do
      product = Product.create(
        name: "Truth Inertia",
        description: "Form over function",
        image: "http://www.truthinertia.com/uploads/4/1/1/8/4118723/591193638.jpg",
        price: 999.99
      )

      get :index

      expect(assigns(:products)).to eq([product])
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @product and renders the show template" do
      product = Product.create(
        name: "Truth Inertia",
        description: "Form over function",
        image: "http://www.truthinertia.com/uploads/4/1/1/8/4118723/591193638.jpg",
        price: 999.99
      )

      get :show, id: product.id

      expect(assigns(:product)).to eq(product)
      expect(response).to render_template("show")
    end
  end
end
