# frozen_string_literal: true

require 'json'
require_relative '../models/product'

class ProductLoaderService
  def self.load_products(file_path)
    products = []
    JSON.parse(File.read(file_path)).each do |product_data|
      products << Product.new(
        uuid: product_data['uuid'],
        name: product_data['name'],
        price: product_data['price']
      )
    end
    products
  end
end