# frozen_string_literal: true

require 'rspec'
require_relative '../../app/presenters/cart_presenter'
require_relative '../../app/services/cart_service'
require_relative '../../app/services/discount_service'
require_relative '../../lib/promotions'
require_relative '../../app/models/cart_item'

RSpec.describe CartPresenter do
  let(:product) { double('Product', name: 'Sample Product', price: 10.00) }
  let(:cart_service) { CartService.new }
  let(:discount_service) { DiscountService }
  let(:presenter) { CartPresenter.new(cart_service, discount_service) }

  before do
    cart_service.add_product(product, 2) # Add a product to the cart
  end

  it 'displays cart information' do
    expect { presenter.display_cart }.to output(/Products in Shopping Cart:/).to_stdout
  end
end