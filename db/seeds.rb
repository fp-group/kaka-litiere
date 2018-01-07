Product.destroy_all

puts "Creating products from Kaka Litter's Catalog..."
litter_bag = Product.create!(sku: "litter-box", designation: "Box of 176 oz", unit_price: 10, features: ["Soft & light", "Stays dry on the surface", "Box with pouring spout"])
box_of_six = Product.create!(sku: "display-box", designation: "Display-box of 6 boxes", unit_price: 50)
