# frozen_string_literal: true

# Product model to calculate tax based on price and category
class Product
  TAX_FREE_CATEGORIES = %w[BOOK FOOD MEDICAL].freeze
  GOOD_TAX = 0.1 # 10%
  IMPORT_TAX = 0.05 # 5%

  attr_reader :name, :category

  def initialize(name, price, category, imported)
    validate(name, price, category, imported)
    @name = name
    @price = price
    @category = category
    @imported = imported
  end

  def raw_price
    @price
  end

  def tax_value
    round_value(good_tax_value + import_tax_value)
  end

  def value_with_tax
    (raw_price + tax_value).round(2)
  end

  def imported?
    @imported
  end

  private

  def good_tax_value
    return 0 if TAX_FREE_CATEGORIES.include?(@category)

    raw_price * GOOD_TAX
  end

  def import_tax_value
    return 0 unless imported?

    raw_price * IMPORT_TAX
  end

  def round_value(value)
    (value * 20).ceil / 20.0
  end

  def validate(name, price, category, imported)
    raise ArgumentError, "name is invalid" unless name.is_a?(String) && !name.empty?
    raise ArgumentError, "price must be a positive float. Got: #{price}" unless price.is_a?(Float) && price >= 0

    unless TAX_FREE_CATEGORIES.include?(category) || category == "OTHER"
      raise ArgumentError,
            "category #{category} is invalid"
    end
    raise ArgumentError, "imported must be a boolean" unless !!imported == imported
  end
end
