# frozen_string_literal: true

# Product model to calculate tax based on price and category
class Product
  TAX_FREE_CATEGORIES = %w[BOOK FOOD MEDICAL].freeze

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
    raise NotImplementedError, "tax_value is not implemented for class #{self.class.name}"
  end

  def value_with_tax
    raise NotImplementedError, "value_with_tax is not implemented for class #{self.class.name}"
  end

  def imported?
    @imported
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
