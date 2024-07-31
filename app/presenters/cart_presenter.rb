# frozen_string_literal: true

class CartPresenter
  def initialize(cart_service, discount_service)
    @cart_service = cart_service
    @discount_service = discount_service
  end

  def display_cart
    items = @cart_service.items
    total = @cart_service.total_price

    if items.empty?
      puts "Your cart is empty."
      return
    end

    puts "Products in Shopping Cart:"
    items.each_with_index do |item, index|
      puts "#{index + 1}. #{item.product.name} - $#{'%.2f' % item.product.price} x #{item.quantity}"
    end

    # Calculate and apply discount
    discount_info = DiscountService.apply_discount(total)
    if discount_info[:discount]
      puts "Discount applied: #{(discount_info[:discount] * 100).to_i}% off on total greater than $#{discount_info[:discount_threshold]}"
      total = discount_info[:total_price]
    else
      puts "No discount applied."
    end

    puts "TOTAL: $#{'%.2f' % total}"
  end
end