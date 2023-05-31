# frozen_string_literal: true

require_relative "product_model"

# Product for invoice, containing quantity
class InvoiceProduct < Product
  attr_reader :qty

  def initialize(name, price, category, imported, quantity)
    super(name, price, category, imported)
    validate_quantity(quantity)
    @qty = quantity
  end

  private

  def validate_quantity(quantity)
    return if quantity.is_a?(Integer) && quantity.positive?

    raise ArgumentError, "quantity must be a positive integer and greater than 0"
  end
end
