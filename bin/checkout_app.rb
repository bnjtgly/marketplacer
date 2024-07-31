# frozen_string_literal: true

require 'json'
require 'bigdecimal'
require_relative '../app/services/product_loader_service'
require_relative '../app/services/cart_service'
require_relative '../app/services/discount_service'
require_relative '../app/presenters/cart_presenter'
require_relative '../lib/promotions'

class CheckoutApp
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

  private

  def print_menu
    puts "-" * 48
    puts "Welcome to the Marketplacer E-commerce Platform!"
    puts "-" * 48
    puts "1. Load Products from File"
    puts "2. List Products"
    puts "3. Add Product to Cart"
    puts "4. View Cart"
    puts "5. Checkout"
    puts "6. Exit"
    puts "-" * 48
    print "Choose an option: "
  end

  def load_products
    loop do
      print "Enter the file path for the products JSON file (or type 'done' to finish): "
      file_path = gets.chomp

      break if file_path.downcase == 'done'

      if @loaded_files.include?(file_path)
        puts "Products from '#{file_path}' have already been loaded."
        next
      end

      begin
        products = ProductLoaderService.load_products(file_path)
        @products.concat(products)
        @loaded_files << file_path # Track the loaded file
        puts "Products from '#{file_path}' loaded successfully."
      rescue Errno::ENOENT
        puts "Error: File not found '#{file_path}'. Please check the file path and try again."
      rescue JSON::ParserError
        puts "Error: File '#{file_path}' could not be parsed. Please ensure it contains valid JSON."
      rescue StandardError => e
        puts "An unexpected error occurred while processing '#{file_path}': #{e.message}"
      end
    end

    puts "All products loaded successfully."
  end

  def list_products
    if @products.empty?
      puts "No products available. Please load products first."
    else
      puts "\nAvailable Products:"
      @products.each_with_index do |product, index|
        puts "#{index + 1}. #{product.name} - $#{'%.2f' % product.price}"
      end
    end
  end

  def add_product_to_cart
    if @products.empty?
      puts "No products available to add to the cart. Please load products first."
      return
    end

    list_products
    print "Enter the product number to add to cart: "
    product_number = gets.chomp.to_i - 1
    product = @products[product_number]

    if product
      print "Enter the quantity: "
      quantity = gets.chomp.to_i
      @cart_service.add_product(product, quantity)
      puts "#{quantity} x #{product.name} added to cart."
    else
      puts "Invalid product number."
    end
  end

  def view_cart
    CartPresenter.new(@cart_service, @discount_service).display_cart
  end

  def display_discount_menu
    puts "\nAvailable Discount Thresholds:"
    Promotions::PROMOTIONS.each do |promo|
      puts "#{(promo[:discount] * 100).to_i}% off on total greater than $#{promo[:threshold]}"
    end
  end

  def checkout
    return puts "Your cart is empty. Add some products before checking out." if @cart_service.items.empty?

    display_discount_menu
    view_cart
    puts "Thank you for your purchase!"
    @checkout_successful = true
  end
end

CheckoutApp.new.run