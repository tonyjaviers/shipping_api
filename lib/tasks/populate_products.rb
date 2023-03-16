# require 'json'

# # Read the contents of the products.json file
# file = File.read('products.json')

# # Parse the contents of the file as JSON
# data = JSON.parse(file)

# # Loop through the array of products
# data['products'].each do |product_data|
#   # For each product, create a new Product object and set its attributes to the values in the JSON
#   product = Product.new
#   product.name = product_data['name']
#   product.type = product_data['type']
#   product.length = product_data['length']
#   product.width = product_data['width']
#   product.height = product_data['height']
#   product.weight = product_data['weight']

#   # Save the new Product object to the database
#   product.save
# end

require 'json'
require 'mongo'

# Connect to the database
client = Mongo::Client.new('mongodb://localhost:27017/products')
products = client[:products]

# Read the products from the JSON file
file = File.read('/path/to/products.json')
data = JSON.parse(file)

# Insert each product into the database
data['products'].each do |product|
  products.insert_one(product)
end

puts 'Products added to the database!'
