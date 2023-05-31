# frozen_string_literal: true

# Product model to calculate tax based on price and category
class Product
  @TAX_FREE_CATEGORIES = %w[BOOK FOOD MEDICAL]

  def initialize(name, price, category, imported)
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
end
