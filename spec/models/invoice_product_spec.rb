# frozen_string_literal: true

RSpec.describe InvoiceProduct do
  describe "constructor" do
    it "should create invoice product with given parameters" do
      parameters = {
        name: "book",
        price: 19.9,
        category: "OTHER",
        imported: false,
        quantity: 2
      }
      product = InvoiceProduct.new(parameters[:name],
                                   parameters[:price],
                                   parameters[:category],
                                   parameters[:imported],
                                   parameters[:quantity])

      expect(product.name).to eq(parameters[:name])
      expect(product.raw_price).to eq(parameters[:price])
      expect(product.category).to eq(parameters[:category])
      expect(product.imported?).to eq(parameters[:imported])
      expect(product.qty).to eq(parameters[:quantity])
    end
  end

  describe "validation" do
    it "should raise ArgumentError if quantity is not an integer" do
      expect do
        InvoiceProduct.new("book", 19.9, "OTHER", false, 2.5)
      end.to raise_error(ArgumentError, "quantity must be a positive integer and greater than 0")
    end

    it "should raise ArgumentError if quantity is 0" do
      expect do
        InvoiceProduct.new("book", 19.9, "OTHER", false, 0)
      end.to raise_error(ArgumentError, "quantity must be a positive integer and greater than 0")
    end

    it "should raise ArgumentError if quantity is negative" do
      expect do
        InvoiceProduct.new("book", 19.9, "OTHER", false, -10)
      end.to raise_error(ArgumentError, "quantity must be a positive integer and greater than 0")
    end
  end

  describe "total_tax" do
    it "should return total tax value" do
      invoice_product = InvoiceProduct.new("imported boxes of chocolates", 11.25, "FOOD", true, 3)

      expect(invoice_product.total_tax).to eq(1.8)
    end
  end
end
