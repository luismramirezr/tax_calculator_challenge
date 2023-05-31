# frozen_string_literal: true

require_relative "invoice_product_model"

# Invoice that contains InvoiceProduct and calculates total tax and invoice value
class Invoice
  attr_reader :products

  def initialize(invoice_products)
    validate(invoice_products)
    @products = invoice_products
  end

  private

  def validate(invoice_products)
    return if invoice_products.is_a?(Array) && invoice_products.all? { |product| product.is_a?(InvoiceProduct) }

    raise ArgumentError, "invoice products must be a instance of InvoiceProduct"
  end
end
