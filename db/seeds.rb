require 'json'

# Load products from JSON file
products_file = File.read("#{Rails.root}/db/products.json")
products_hash = JSON.parse(products_file)

# Create products
products_hash['products'].each do |product_hash|
  Product.create(product_hash)
end
