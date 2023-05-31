# frozen_string_literal: true

RSpec.describe Invoice do
  describe "constructor" do
    it "should create invoice with given products" do
      product1 = InvoiceProduct.new("book", 12.49, "BOOK", false, 2)
      product2 = InvoiceProduct.new("music cd", 14.99, "OTHER", false, 1)
      product3 = InvoiceProduct.new("chocolate bar", 0.85, "FOOD", false, 1)

      invoice = Invoice.new([product1, product2, product3])

      expect(invoice.products.length).to be(3)
    end
  end

  describe "validation" do
    it "should raise ArgumentError if given products is not an array" do
      product = InvoiceProduct.new("book", 12.49, "BOOK", false, 2)

      expect do
        Invoice.new(product)
      end.to raise_error(ArgumentError, "invoice products must be a instance of InvoiceProduct")
    end

    it "should raise ArgumentError if one of the elements of the given products array is not a InvoiceProduct" do
      invoice_product = InvoiceProduct.new("book", 12.49, "BOOK", false, 2)
      product = Product.new("book", 12.49, "BOOK", false)

      expect do
        Invoice.new([invoice_product, product])
      end.to raise_error(ArgumentError, "invoice products must be a instance of InvoiceProduct")
    end
  end

  describe "tax_value" do
    it "should return all the taxes from the products" do
      product1 = InvoiceProduct.new("book", 12.49, "BOOK", false, 2)
      product2 = InvoiceProduct.new("music cd", 14.99, "OTHER", false, 1)
      product3 = InvoiceProduct.new("chocolate bar", 0.85, "FOOD", false, 1)

      invoice = Invoice.new([product1, product2, product3])

      expect(invoice.tax_value).to be(1.50)
    end
  end
end
