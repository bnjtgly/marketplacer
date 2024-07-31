# frozen_string_literal: true

class CartItem
  attr_accessor :product, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end
end