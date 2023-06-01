# frozen_string_literal: true

RSpec.describe TaxCalculator do
  it "has a version number" do
    expect(TaxCalculator::VERSION).not_to be nil
  end

  it "prints expected output" do
    input = "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85"
    expected_output = "2 book: 24.98"
    expected_output += "\n1 music CD: 16.49"
    expected_output += "\n1 chocolate bar: 0.85"
    expected_output += "\nSales Taxes: 1.50"
    expected_output += "\nTotal: 42.32"

    expect(TaxCalculator.print_invoice(input)).to eq(expected_output)
  end

  describe "provided inputs" do
    shared_examples :test_provided_input do |input, expected_output|
      it "should return expected value with provided input" do
        expect(TaxCalculator.print_invoice(input)).to eq(expected_output)
      end
    end

    describe "input 1" do
      include_examples :test_provided_input, "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85",
                       "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32"
    end

    describe "input 2" do
      include_examples :test_provided_input, "1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50",
                       "1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15"
    end

    describe "input 3" do
      include_examples :test_provided_input, "1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n3 imported boxes of chocolates at 11.25",
                       "1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n3 imported boxes of chocolates: 35.55\nSales Taxes: 7.90\nTotal: 98.38"
    end
  end
end
