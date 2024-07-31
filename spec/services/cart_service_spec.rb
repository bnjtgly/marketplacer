# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/services/cart_service'
require_relative '../../app/services/product_loader_service'

RSpec.describe CartService, type: :service do
  before do
    @cart_service = CartService.new
    @product = double('Product', name: 'Test Product', price: 10.0)
  end

  it 'adds product to cart' do
    @cart_service.add_product(@product, 1)
    expect(@cart_service.items.size).to eq(1)
  end

  it 'calculates total price correctly' do
    @cart_service.add_product(@product, 2)
    expect(@cart_service.total_price).to eq(20.0)
  end
end