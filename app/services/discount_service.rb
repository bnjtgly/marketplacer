# frozen_string_literal: true

require_relative '../../lib/promotions'

class DiscountService
  def self.apply_discount(total_price)
    applicable_promotion = Promotions::PROMOTIONS
                             .select { |promo| total_price > promo[:threshold] }
                             .max_by { |promo| promo[:discount] }

    if applicable_promotion
      discount_amount = total_price * applicable_promotion[:discount]
      discounted_price = total_price - discount_amount

      {
        total_price: discounted_price.round(2),  # Ensure two decimal places
        discount: applicable_promotion[:discount],
        discount_threshold: applicable_promotion[:threshold]
      }
    else
      {
        total_price: total_price.round(2),  # Ensure two decimal places
        discount: nil,
        discount_threshold: nil
      }
    end
  end
end