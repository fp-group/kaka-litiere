Product.destroy_all

puts "Creating products from Kaka Litter's Catalog..."
litter_bag = Product.create!(sku: "litter-box", designation: "Boite de 5kg", unit_price: 10, features: ["Douce et légère", "Reste sèche en surface", "Avec un bec verseur"])
box_of_six = Product.create!(sku: "display-box", designation: "Box de 6 boites", unit_price: 50)
