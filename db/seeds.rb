
puts "Destroy previous seeds..."
OrderDetail.destroy_all
Product.destroy_all
Order.destroy_all
ShippingAddress.destroy_all
Company.destroy_all
User.destroy_all


puts "Creating users..."
filzi     = User.create!(first_name: "Nicolas", last_name: "Filzi", email: "nfilzi.webservices@gmail.com", password: "password", phone_number: "+33678380989")
pariente  = User.create!(first_name: "Thomas", last_name: "Pariente", email: "parientethomas@gmail.com", password: "password", phone_number: "+33661011209")

puts "Building companies..."
filzi_co    = Company.new(user: filzi, name: "Filzi Company", phone_number: "+33678380989", vat_number: "08028402824022")
pariente_co = Company.new(user: pariente, name: "Pariente Company", phone_number: "+33661011209", vat_number: "08028402824023")


filzi_co_ship_and_bill_address    = "4 place Charles Fillion, 75017 Paris"
pariente_co_ship_and_bill_address = "14 allée Eric Chaber, 75013 Paris"

puts "Adding addresses (billing and shipping) to companies..."
filzi_co.shipping_addresses.build(designation: filzi_co_ship_and_bill_address)
pariente_co.shipping_addresses.build(designation: pariente_co_ship_and_bill_address)

filzi_co.billing_address    = filzi_co_ship_and_bill_address
pariente_co.billing_address = pariente_co_ship_and_bill_address

filzi_co.save
pariente_co.save

puts "Companies created!"

puts "Creating products from Kaka Litter's Catalog..."
litter_bag = Product.create!(designation: "Litter Bag of 176oz", unit_price: 3.4, features: ["100% mineral", "Odorless", "Absorbent", "Clumping"])
box_of_six = Product.create!(designation: "Box of 6 bags", unit_price: 19.0, features: ["Better storage", "Better display", "Easier to pick from", "Cheaper"])

puts "Creating orders for both companies..."
[filzi, pariente].each do |user|
  rand(5..10).times do |step|
    rand_shipping_address = user.company.shipping_addresses.sample

    puts "Creating order n°#{step + 1} for #{user.company.name}"

    order                 = Order.new(company: user.company, shipping_address: rand_shipping_address)
    order.first_order! if user.company.no_orders_yet?


    order.order_details.build(quantity: rand(1..4), product: box_of_six)
    order.order_details.build(quantity: rand(1..10), product: litter_bag)

    order.compute_total_price_ht!
    order.save!
  end
end
