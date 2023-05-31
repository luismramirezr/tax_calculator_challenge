# frozen_string_literal: true

RSpec.describe Product do
  describe "constructor" do
    it "should create product with given parameters" do
      parameters = {
        name: "book",
        price: 19.9,
        category: "OTHER",
        imported: false
      }
      product = Product.new(parameters[:name], parameters[:price], parameters[:category], parameters[:imported])

      expect(product.name).to eq(parameters[:name])
      expect(product.raw_price).to eq(parameters[:price])
      expect(product.category).to eq(parameters[:category])
      expect(product.imported?).to eq(parameters[:imported])
    end
  end

  describe "validation" do
    shared_examples :validation do |parameter_name, parameter_value, expected_error, error_description|
      parameters = {
        name: "book",
        price: 19.9,
        category: "BOOK",
        imported: false
      }
      parameters[parameter_name.to_sym] = parameter_value
      it "should raise ArgumentError if #{parameter_name} #{error_description}" do
        expect do
          Product.new(parameters[:name], parameters[:price], parameters[:category],
                      parameters[:imported])
        end.to raise_error(ArgumentError, expected_error)
      end
    end

    describe "name" do
      include_examples :validation, "name", 123, "name is invalid", "name is not a string"
      include_examples :validation, "name", "", "name is invalid", "name is empty"
    end

    describe "category" do
      include_examples :validation, "category", "INVALID_CATEGORY", "category INVALID_CATEGORY is invalid",
                       "category is not present in TAX_FREE_CATEGORIES or does not equals 'OTHER'"
    end

    describe "price" do
      include_examples :validation, "price", "price", "price must be a positive float. Got: price", "price is a string"
      include_examples :validation, "price", 123, "price must be a positive float. Got: 123", "price is an integer"
      include_examples :validation, "price", -19.9, "price must be a positive float. Got: -19.9",
                       "price is a negative float"
    end

    describe "imported" do
      include_examples :validation, "imported", "true", "imported must be a boolean", "imported is not a boolean"
    end
  end

  describe "tax_value" do
    shared_examples :tax_value do |name, price, category, imported, expected, test_label|
      it "should return #{test_label}" do
        product = Product.new(name, price, category, imported)

        tax_value = product.tax_value

        expect(tax_value).to be(expected)
      end
    end

    it "should round up tax value to nearest 0.05" do
      parameters = {
        name: "music cd",
        price: 14.99,
        category: "OTHER",
        imported: false
      }
      product = Product.new(parameters[:name], parameters[:price], parameters[:category], parameters[:imported])

      tax_value = product.tax_value

      expect(tax_value).to be(1.5)
    end

    describe "good tax" do
      include_examples :tax_value, "book", 20.0, "OTHER", false, 2.0,
                       "only good tax value when category is OTHER and is not imported"
      include_examples :tax_value, "book", 19.9, "BOOK", false, 0.0,
                       "0 when category is in TAX_FREE_CARTEGORIES and is not imported"
    end

    describe "import tax" do
      include_examples :tax_value, "imported chocolate", 10.0, "FOOD", true, 0.5,
                       "only import tax value when category is in TAX_FREE_CATEGORIES and is imported"
      include_examples :tax_value, "imported perfume", 47.50, "OTHER", true, 7.15,
                       "import tax value and import good tax value when category is not in TAX_FREE_CATEGORIES and is imported"
    end
  end
end
