# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/marketplacer'

RSpec.describe Marketplacer do
  let(:dummy) { Class.new { extend Marketplacer } }
  let(:cart_service) { double('CartService', items: [double('Product')]) }
  let(:discount_service) { double('DiscountService') }
  let(:product) { double('Product', uuid: '1234', name: 'Sample Product', price: 10.0) }
  let(:file_path) { 'spec/fixtures/products.json' }

  before do
    dummy.instance_variable_set(:@cart_service, cart_service)
    dummy.instance_variable_set(:@discount_service, discount_service)
    dummy.instance_variable_set(:@products, [])
    dummy.instance_variable_set(:@loaded_files, [])
  end

  describe '#print_menu' do
    it 'prints the menu to the console' do
      expect { dummy.print_menu }.to output(
                                       "-" * 48 + "\n" +
                                         "Welcome to the Marketplacer E-commerce Platform!\n" +
                                         "-" * 48 + "\n" +
                                         "1. Load Products from File\n" +
                                         "2. List Products\n" +
                                         "3. Add Product to Cart\n" +
                                         "4. View Cart\n" +
                                         "5. Checkout\n" +
                                         "6. Exit\n" +
                                         "-" * 48 + "\n" +
                                         "Choose an option: "
                                     ).to_stdout
    end
  end

  describe '#list_products' do
    context 'when there are no products' do
      it 'prints a message indicating no products are available' do
        dummy.instance_variable_set(:@products, [])
        expect { dummy.list_products }.to output(
                                            "No products available. Please load products first.\n"
                                          ).to_stdout
      end
    end

    context 'when there are products' do
      it 'lists all available products' do
        dummy.instance_variable_set(:@products, [product])
        expect { dummy.list_products }.to output(
                                            "\nAvailable Products:\n1. Sample Product - $10.00\n"
                                          ).to_stdout
      end
    end
  end

  describe '#view_cart' do
    it 'calls CartPresenter to display the cart' do
      presenter = instance_double('CartPresenter')
      allow(CartPresenter).to receive(:new).and_return(presenter)
      expect(presenter).to receive(:display_cart)
      dummy.view_cart
    end
  end

  describe '#display_discount_menu' do
    it 'prints the discount menu with correct thresholds' do
      allow(Promotions).to receive(:const_get).with(:PROMOTIONS).and_return([
                                                                              { discount: 0.20, threshold: 100 },
                                                                              { discount: 0.15, threshold: 50 },
                                                                              { discount: 0.10, threshold: 20 }
                                                                            ])

      expected_output = "\nAvailable Discount Thresholds:\n" +
        "20% off on total greater than $100\n" +
        "15% off on total greater than $50\n" +
        "10% off on total greater than $20\n"

      expect { dummy.display_discount_menu }.to output(expected_output).to_stdout
    end
  end

  describe '#checkout' do
    it 'displays the discount menu and views the cart' do
      cart_presenter = double('CartPresenter')
      allow(CartPresenter).to receive(:new).and_return(cart_presenter)
      allow(cart_presenter).to receive(:display_cart)

      allow(Promotions).to receive(:const_get).with(:PROMOTIONS).and_return([{ discount: 0.1, threshold: 50 }])

      expect { dummy.checkout }.to output(/Available Discount Thresholds:/).to_stdout
      expect { dummy.checkout }.to output(/Thank you for your purchase!/).to_stdout
    end
  end
end
