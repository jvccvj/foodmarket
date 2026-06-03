require "test_helper"

class PricesApiTest < ActionDispatch::IntegrationTest
  test "should get all prices" do
    Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.50,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    get "/api/prices"
    
    assert_response :success
    
    json = JSON.parse(response.body)
    assert_equal 1, json["prices"].count
    assert_equal "Cerezas", json["prices"][0]["item"]
    assert_equal 2.50, json["prices"][0]["price"]
    assert_equal "05", json["prices"][0]["day"]
    assert_equal "May", json["prices"][0]["month"]
  end

  test "should get single price" do
    price = Price.create!(
      item: "Fresones",
      day: "10",
      month: "Apr",
      price: 2.34,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 4, 10)
    )
    
    get "/api/prices/#{price.id}"
    
    assert_response :success
    
    json = JSON.parse(response.body)
    assert_equal "Fresones", json["price"]["item"]
    assert_equal 2.34, json["price"]["price"]
    assert_equal "10", json["price"]["day"]
  end

  test "should return 404 for nonexistent price" do
    get "/api/prices/99999"
    assert_response :not_found
  end

  test "prices should be ordered by recorded_at" do
    Price.create!(
      item: "Cerezas",
      day: "22",
      month: "May",
      price: 2.21,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 22)
    )
    
    Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.44,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    get "/api/prices"
    
    assert_response :success
    
    json = JSON.parse(response.body)
    assert_equal "05", json["prices"][0]["day"]
    assert_equal "22", json["prices"][1]["day"]
  end

  test "should include all required fields" do
    price = Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.44,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    get "/api/prices/#{price.id}"
    
    assert_response :success
    
    json = JSON.parse(response.body)["price"]
    assert_not_nil json["id"]
    assert_not_nil json["item"]
    assert_not_nil json["price"]
    assert_not_nil json["day"]
    assert_not_nil json["month"]
    assert_not_nil json["unit"]
    assert_not_nil json["recorded_at"]
  end

  test "should handle European decimal format" do
    price = Price.create!(
      item: "Cerezas",
      day: "05",
      month: "May",
      price: 2.55,
      unit: "EUR/kg",
      recorded_at: Date.new(2026, 5, 5)
    )
    
    get "/api/prices/#{price.id}"
    
    assert_response :success
    
    json = JSON.parse(response.body)
    assert_equal 2.55, json["price"]["price"]
    assert_instance_of Float, json["price"]["price"]
  end
end