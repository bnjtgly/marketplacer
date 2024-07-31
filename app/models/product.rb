# frozen_string_literal: true

require 'bigdecimal'

class Product
  attr_reader :uuid, :name, :price

  def initialize(uuid:, name:, price:)
    @uuid = uuid
    @name = name
    @price = BigDecimal(price)
  end
end