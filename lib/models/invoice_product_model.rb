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

  def total_tax
    (tax_value * qty).round(2)
  end

  def total_with_tax
    (value_with_tax * qty).round(2)
  end

  private

  def validate_quantity(quantity)
    return if quantity.is_a?(Integer) && quantity.positive?

    raise ArgumentError, "quantity must be a positive integer and greater than 0"
  end
end
