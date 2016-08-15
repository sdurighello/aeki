# AEKI - Japanese Furniture Store

Rails app for a basic store with products, shopping cart, orders and users.

*Gems:*
1. Devise
2. CanCanCan
3. Carrierwave + Cloudinary

## Steps

These are the steps I followed when working on this app:

1. Define data-model
2. Define screen flow
3.

## Database Structure

1. Product_type
  * name:string
  * description:text
  * image:string

  * has_many :products

2. Product
  * name:string
  * description:text
  * image:string
  * price:float

  * belongs_to :product_type
  * belongs_to :inventory
  * has_many :line_items

3. Inventory
  * quantity:integer

  * has_many :products

4. Cart
  * has_many :line_items

5. Line_item
  * price (empty till checkout?)
  * quantity

  * belongs_to :cart
  * belongs_to :product
  * belongs_to :order

6. Order
  * belongs_to :user
  * has_many :line_items

  * model method: availability_check()

7. User
  * standard devise fields (email, password)

  * has_one :profile
  * has_many :orders

8. Profile
  * name:string
  * address:string
  * image:string
  * authorization_level

  * belongs_to :user

-- Session:
  * session[cart_id, user_id]

-- availability_check
  * product with quantity 0 cannot be added to cart (button "AddToCart" disabled). Method in product model.
  * Every time quantity in cart is changed, availability should be checked
  * When you add the same product to the cart, availability should be checked

-- cart line items
  * When the same product is added to cart, only the quantity should change

-- update Inventory
  * When an order is placed, inventory quantity for the product should be updated. Class method on Inventory model that takes product_id, quantity.

-- cart management
  * at checkout, line items are copied from cart to order
  * at place order, cart is destroyed





## Screen flow

1. Homepage
  * Menu with user/login
  * Welcome header (image/jumbotron?)
  * Thumbnail for each product_type (clickable)

2. Catalog page - one page for each product type
  * Header with product type name, description and image
  * Body with thumbnails for each product belonging to the type (clickable)

3. Product page - one page for each product
  * Product name, description, image
  * Button "Add to cart"

4. Shopping cart bar
  -- If not empty displayed on every page --
  * List of line items with product, quantity, price, total_price_line and total_price_cart
  * Button "Checkout"

5. Order
  * Copy of cart with line_items
  * Button "Place order" to complete flow
