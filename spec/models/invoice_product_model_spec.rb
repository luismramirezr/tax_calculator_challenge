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
      invoice_product = InvoiceProduct.new(parameters[:name],
                                                   parameters[:price],
                                                   parameters[:category],
                                                   parameters[:imported],
                                                   parameters[:quantity])

      expect(invoice_product.name).to eq(parameters[:name])
      expect(invoice_product.raw_price).to eq(parameters[:price])
      expect(invoice_product.category).to eq(parameters[:category])
      expect(invoice_product.imported?).to eq(parameters[:imported])
      expect(invoice_product.qty).to eq(parameters[:quantity])
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
    it "should return total tax value rounded to 2 decimal places" do
      invoice_product = InvoiceProduct.new("imported boxes of chocolates", 11.25, "FOOD", true, 3)

      expect(invoice_product.total_tax).to eq(1.8)
    end
  end

  describe "total_with_tax" do
    it "should return total value with tax rounded to 2 decimal places" do
      invoice_product = InvoiceProduct.new("imported boxes of chocolates", 11.25, "FOOD", true, 3)

      expect(invoice_product.total_with_tax).to eq(35.55)
    end
  end

  describe "provided inputs" do
    shared_examples :test_provided_input do |name, price, category, imported, qty, expected|
      it "should return #{expected} for #{qty}#{imported ? " imported " : ""} #{name} at #{price}" do
        invoice_product = InvoiceProduct.new(name, price, category, imported, qty)

        total_with_tax = invoice_product.total_with_tax

        expect(total_with_tax).to be(expected)
      end
    end

    describe "input 1" do
      include_examples :test_provided_input, "book", 12.49, "BOOK", false, 2, 24.98
      include_examples :test_provided_input, "music cd", 14.99, "OTHER", false, 1, 16.49
      include_examples :test_provided_input, "chocolate bar", 0.85, "FOOD", false, 1, 0.85
    end

    describe "input 2" do
      include_examples :test_provided_input, "box of chocolates", 10.0, "FOOD", true, 1, 10.50
      include_examples :test_provided_input, "bottle of perfume", 47.5, "OTHER", true, 1, 54.65
    end

    describe "input 3" do
      include_examples :test_provided_input, "bottle of perfume", 27.99, "OTHER", true, 1, 32.19
      include_examples :test_provided_input, "bottle of perfume", 18.99, "OTHER", false, 1, 20.89
      include_examples :test_provided_input, "packet of headache pills", 9.75, "MEDICAL", false, 1, 9.75
      include_examples :test_provided_input, "boxes of chocolate", 11.25, "FOOD", true, 3, 35.55
    end
  end
end
