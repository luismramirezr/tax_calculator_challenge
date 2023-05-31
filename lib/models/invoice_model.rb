# frozen_string_literal: true

require_relative "invoice_product_model"

# Invoice that contains InvoiceProduct and calculates total tax and invoice value
class Invoice
  attr_reader :products

  def initialize(invoice_products)
    validate(invoice_products)
    @products = invoice_products
  end

  def tax_value
    @products.reduce(0) { |sum, product| sum + product.total_tax }
  end

  def total
    @products.reduce(0) { |sum, product| sum + product.total_with_tax }
  end

  def invoice
    products = @products.reduce("") do |str, product|
      str + "#{product.qty} #{product.name}: #{format("%.2f", product.total_with_tax)}\n"
    end
    products += "Sales Taxes: #{format("%.2f", tax_value)}"
    products += "\nTotal: #{format("%.2f", total)}"
    products
  end

  private

  def validate(invoice_products)
    return if invoice_products.is_a?(Array) && invoice_products.all? { |product| product.is_a?(InvoiceProduct) }

    raise ArgumentError, "invoice products must be a instance of InvoiceProduct"
  end
end
