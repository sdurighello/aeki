
# Delete all tables

Product.delete_all
Profile.delete_all
User.delete_all
Role.delete_all

# -- Setup Roles and Admin User --

admin_role = Role.create(name: "Admin", description: "Administrator that can update products")
customer_role = Role.create(name: "Customer", description: "Customer that can buy stuff")

# -- Setup Admin User --

admin_user = User.create(email: "admin@aeki.com", password: "adminadmin", role: admin_role)

# -- Customers --

jack = User.create(email: "jack@chairs.com", password: "abcd1234", role: customer_role)
james = User.create(email: "james@chairs.com", password: "abcd1234", role: customer_role)
julia = User.create(email: "julia@chairs.com", password: "abcd1234", role: customer_role)
jasmine = User.create(email: "jasmine@chairs.com", password: "abcd1234", role: customer_role)

# -- Profiles --

pf_jack = Profile.create(first_name: "Jack", surname: "Jacobsen", addr_street: "Weesperstraat 22", addr_postcode: "1443AA", addr_town: "Amsterdam", gender: "male", user: jack )
pf_james = Profile.create(first_name: "James", surname: "Jarvis", addr_street: "Damrak 2", addr_postcode: "1232AA", addr_town: "Amsterdam", gender: "male", user: james )
pf_julia = Profile.create(first_name: "Julia", surname: "Johnston", addr_street: "Keizersgracht 34", addr_postcode: "1883DF", addr_town: "Amsterdam", gender: "female", user: julia )
pf_jasmine = Profile.create(first_name: "Jasmine", surname: "Jonker", addr_street: "Prinsengracht 244", addr_postcode: "1253DA", addr_town: "Amsterdam", gender: "female", user: jasmine )
pf_admin_user = Profile.create(first_name: "Boris", surname: "Boss", user: admin_user)

# -- Products --

Product.create(
  name: "Truth Inertia",
  description: "Form over function",
  image: open("http://www.truthinertia.com/uploads/4/1/1/8/4118723/591193638.jpg"),
  price: 999.99
)

Product.create(
  name: "Cloud #9",
  description: "Tasty design from Uzbekistan",
  image: open("http://2.bp.blogspot.com/-aGF1C41GMk8/Ta3QRMaQ0sI/AAAAAAAAAXw/3q_gn1t5IOU/s1600/spoon-chair.jpg"),
  price: 899.99
)

Product.create(
  name: "Static Enhancement",
  description: "Prickle your senses",
  image: open("https://img.buzzfeed.com/buzzfeed-static/static/2014-01/enhanced/webdr06/14/5/enhanced-buzz-18735-1389693709-10.jpg"),
  price: 1499.99
)

Product.create(
  name: "SoBadSoGood",
  description: "Design with fangs",
  image: open("http://sobadsogood.com/uploads/stories/2015/06/05/This-Is-The-Most-Uncomfortable-Chair-Ever.jpg"),
  price: 1049.99
)

Product.create(
  name: "Urbanist's Web",
  description: "Less is more back ache",
  image: open("http://img.weburbanist.com/wp-content/uploads/2009/10/Uncomfortable_Chairs_4a.jpg"),
  price: 649.99
)
