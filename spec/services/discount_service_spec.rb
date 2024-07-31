# frozen_string_literal: true
# frozen_string_literal: true

require 'rspec'
require_relative '../../app/services/discount_service'
require_relative '../../lib/promotions'

RSpec.describe DiscountService do
  before(:each) do
    # Use a new array for testing
    @original_promotions = Promotions::PROMOTIONS.dup
  end

  after(:each) do
    # Restore the original promotions after the test
    # This will only work if PROMOTIONS is not frozen
    Promotions.send(:remove_const, :PROMOTIONS)
    Promotions.const_set(:PROMOTIONS, @original_promotions)
  end

  it 'applies the correct discount' do
    Promotions.const_set(:PROMOTIONS, @original_promotions + [{ threshold: 20, discount: 0.10 }])
    total_price = 30
    expect(DiscountService.apply_discount(total_price)).to include(
                                                             total_price: 27.00, # 30 - 10% of 30
                                                             discount: 0.10,
                                                             discount_threshold: 20
                                                           )
  end

  it 'does not apply a discount if none is applicable' do
    Promotions.const_set(:PROMOTIONS, @original_promotions)
    total_price = 10
    expect(DiscountService.apply_discount(total_price)).to include(
                                                             total_price: 10.00,
                                                             discount: nil,
                                                             discount_threshold: nil
                                                           )
  end
end