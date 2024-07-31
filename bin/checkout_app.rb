# frozen_string_literal: true

require 'json'
require 'bigdecimal'
require_relative '../app/services/product_loader_service'
require_relative '../app/services/cart_service'
require_relative '../app/services/discount_service'
require_relative '../app/presenters/cart_presenter'
require_relative '../lib/promotions'
require_relative '../lib/marketplacer'

class CheckoutApp
  include Marketplacer

  def initialize
    @products = []
    @cart_service = CartService.new
    @discount_service = DiscountService
    @loaded_files = []
  end

  def run
    loop do
      print_menu
      choice = gets.chomp.to_i

      case choice
      when 1
        load_products
      when 2
        list_products
      when 3
        add_product_to_cart
      when 4
        view_cart
      when 5
        checkout
        break if @checkout_successful
      when 6
        puts "Thank you for using Marketplacer. Goodbye!"
        break
      else
        puts "Invalid option. Please try again."
      end
    end
  end
end

CheckoutApp.new.run
