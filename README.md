# TaxCalculator

TaxCalculator gem. It accepts a string in the following format:

```bash
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

It will calculate taxes and total value based on the following rules:

1. All goods have a tax rate of 10% except books, food, and medical products
1. Imported products have an additional rate of 5%, with no exemptions
1. Tax is rounded to the next 0.05 multiple

Output should be total value per item, total taxes and total invoice value:

```bash
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

## Installation

Build the gem:

```bash
gem build tax_calculator.gemspec
```

Then, install:

```bash
gem install ./tax_calculator-0.1.0.gem
```

Finally, run in bash:

```bash
irb
irb(main):001:0> require 'tax_calculator'
=> true
```

## Usage

Call `TaxCalculator.print_invoice` with a string of products:

```bash
irb(main):002:0> input = "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85"
=> "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85"
irb(main):003:0> TaxCalculator.print_invoice(input)
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
=> "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32"
```

## Limitations
1. Gem only accepts integers for quantity and float for price
1. Product categorization is based on the words "book", "pills" and "chocolate"
1. Import tax is applied when product has "imported" in description
1. Input should have the same structure: "{qty} {description} at {float price}", with one product per line
