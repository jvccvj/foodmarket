require "application_system_test_case"

class ChartsTest < ApplicationSystemTestCase
  test "should display prices chart" do
    Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.44,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    visit charts_url
    
    assert_selector "h2", text: "Daily Wholesale Market Prices"
  end

  test "should show price data in table" do
    Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.44,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    visit charts_url
    
    assert_text "Cerezas"
    assert_text "€2.44"
    assert_text "05/May/2026"
  end

  test "should display multiple products" do
    Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.44,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    Price.create!(
      item: "Fresones",
      day: "10",
      month: "Apr",
      price: 2.34,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 4, 10)
    )
    
    visit charts_url
    
    assert_text "Cerezas"
    assert_text "Fresones"
  end
end