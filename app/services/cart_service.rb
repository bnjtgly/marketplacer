# frozen_string_literal: true

require_relative '../models/cart_item'

class CartService
  def initialize
    @items = []
  end

  def items
    @items
  end

  def add_product(product, quantity)
    cart_item = @items.find { |item| item.product == product }
    if cart_item
      cart_item.quantity += quantity
    else
      @items << CartItem.new(product, quantity)
    end
  end

  def total_price
    @items.sum { |item| item.product.price * item.quantity }
  end
end