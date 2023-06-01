# frozen_string_literal: true

require_relative "tax_calculator/version"
require_relative "models/invoice_model"

# Calculates total value and tax value for a list of products
module TaxCalculator
  def self.print_invoice(products)
    parsed_products = parse_products(products)
    invoice_products = parsed_products.map do |product|
      InvoiceProduct.new(product[:description], product[:price], product[:category], product[:imported], product[:qty])
    end
    invoice = Invoice.new(invoice_products)
    invoice = invoice.to_s
    puts invoice
    invoice
  end

  def self.parse_products(products)
    products.split("\n").map do |line|
      match = line.match(/(\d+)\s+(.*) at (\d+\.\d+)/)
      quantity = match[1].to_i
      description = match[2]
      price = match[3].to_f
      imported = description.include?("imported")
      {
        qty: quantity,
        description: description,
        price: price,
        imported: imported,
        category: get_category(description)
      }
    end
  end

  def self.get_category(description)
    if description.include?("book")
      "BOOK"
    elsif description.include?("chocolate")
      "FOOD"
    elsif description.include?("pills")
      "MEDICAL"
    else
      "OTHER"
    end
  end
end
