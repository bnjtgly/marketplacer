# frozen_string_literal: true

module Promotions
  PROMOTIONS = [
    { threshold: 100, discount: 0.20 },
    { threshold: 50, discount: 0.15 },
    { threshold: 20, discount: 0.10 }
  ].freeze
end