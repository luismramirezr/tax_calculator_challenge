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
      puts parameters
      parameters[parameter_name.to_sym] = parameter_value
      puts parameters
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
end
