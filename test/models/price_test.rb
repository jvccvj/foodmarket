require "test_helper"

class PriceTest < ActiveSupport::TestCase
  test "should be valid with all attributes" do
    price = Price.new(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.50,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    assert price.valid?
  end

  test "should require item" do
    price = Price.new(price: 2.50, unit: "EUR/kg")
    assert_not price.valid?
    assert_includes price.errors[:item], "can't be blank"
  end

  test "should require day" do
    price = Price.new(item: "Cerezas", price: 2.50, unit: "EUR/kg")
    assert_not price.valid?
    assert_includes price.errors[:day], "can't be blank"
  end

  test "should require month" do
    price = Price.new(item: "Cerezas", day: "05", price: 2.50, unit: "EUR/kg")
    assert_not price.valid?
    assert_includes price.errors[:month], "can't be blank"
  end

  test "should require price" do
    price = Price.new(item: "Cerezas", day: "05", month: "May", unit: "EUR/kg")
    assert_not price.valid?
    assert_includes price.errors[:price], "can't be blank"
  end

  test "should require unit" do
    price = Price.new(item: "Cerezas", day: "05", month: "May", price: 2.50)
    assert_not price.valid?
    assert_includes price.errors[:unit], "can't be blank"
  end

  test "should have unique item-day combination" do
    Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.50,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    duplicate = Price.new(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.75,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    assert_not duplicate.valid?
  end

  test "should allow same item different day" do
    Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.50,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    different_day = Price.new(
      item: "Cerezas",
      day: "08",
      month: "May",
      price: 2.75,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 8)
    )
    assert different_day.valid?
  end

  test "should have valid price formats" do
    price = Price.new(
      item: "Test",
      day: "01",
      month: "Jan",
      price: 1.99,
      unit: "EUR/kg"
    )
    assert price.valid?
    
    price.price = 100.50
    assert price.valid?
    
    price.price = 0.01
    assert price.valid?
  end
end