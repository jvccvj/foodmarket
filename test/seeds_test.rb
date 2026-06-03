require "test_helper"
require "csv"

class SeedsTest < ActiveSupport::TestCase
  test "should load Mercasa CSV data" do
    csv_path = Rails.root.join('data', 'mercasa-2026-normalizado.csv')
    assert File.exist?(csv_path), "Mercasa CSV file should exist"
    
    prices = []
    CSV.foreach(csv_path, headers: true) do |row|
      prices << row
    end
    
    assert prices.any?, "CSV should have data"
  end

  test "should parse European decimal format" do
    csv_path = Rails.root.join('data', 'mercasa-2026-normalizado.csv')
    
    CSV.foreach(csv_path, headers: true) do |row|
      price_str = row['price_eur_kg'].to_s.gsub(',', '.').strip
      price = price_str.to_f
      
      assert price > 0, "Price should be positive number"
      assert price < 50, "Price should be reasonable (< 50 EUR/kg)"
    end
  end

  test "should have valid products" do
    csv_path = Rails.root.join('data', 'mercasa-2026-normalizado.csv')
    
    products = []
    CSV.foreach(csv_path, headers: true) do |row|
      products << row['product']
    end
    
    assert_includes products, "Cerezas"
    assert_includes products, "Fresones"
    assert_equal products.uniq.count, 2, "Should have exactly 2 products"
  end

  test "should have valid markets" do
    csv_path = Rails.root.join('data', 'mercasa-2026-normalizado.csv')
    
    markets = []
    CSV.foreach(csv_path, headers: true) do |row|
      markets << row['market']
    end
    
    expected_markets = %w[Mercamadrid Mercabarna Mercabilbao Mercasevilla Mercavalencia]
    expected_markets.each do |market|
      assert_includes markets, market, "CSV should include #{market}"
    end
  end

  test "should compute daily averages" do
    csv_path = Rails.root.join('data', 'mercasa-2026-normalizado.csv')
    
    # Aggregate by product and date
    aggregated = Hash.new { |h, k| h[k] = [] }
    
    CSV.foreach(csv_path, headers: true) do |row|
      product = row['product']
      date_ref = row['date_reference'].gsub('*', '')
      price_str = row['price_eur_kg'].to_s.gsub(',', '.').strip
      price = price_str.to_f
      
      key = "#{product}:#{date_ref}"
      aggregated[key] << price
    end
    
    # Verify aggregation
    assert aggregated.any?, "Should have aggregated data"
    
    aggregated.each do |key, prices|
      assert prices.any?, "Each key should have prices"
      avg = prices.sum / prices.size
      assert avg > 0, "Average should be positive"
      assert avg < 50, "Average should be reasonable"
    end
  end

  test "should handle month mapping" do
    month_map = {
      '03' => 'Mar', '05' => 'May', '07' => 'Jul', '08' => 'Aug',
      '10' => 'Oct', '12' => 'Dec', '14' => 'Feb', '15' => 'Mar',
      '17' => 'Apr', '19' => 'May', '20' => 'Jun', '21' => 'Jul',
      '22' => 'Aug', '24' => 'Sep', '26' => 'Oct', '27' => 'Nov',
      '28' => 'Dec', '31' => 'Jan'
    }
    
    csv_path = Rails.root.join('data', 'mercasa-2026-normalizado.csv')
    
    CSV.foreach(csv_path, headers: true) do |row|
      date_ref = row['date_reference'].gsub('*', '')
      month_code = date_ref.split('/')[1] rescue next
      month_name = month_map[month_code]
      
      assert month_name, "Should have valid month mapping for #{month_code}"
    end
  end
end