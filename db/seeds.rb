# Fresh food prices from Mercasa CSV data
# Source: Spanish wholesale markets (Mercamadrid, Mercabarna, etc.)
# Products: Cerezas (Cherries), Fresones (Strawberries)
# Aggregation: daily average across all markets

require 'csv'

Price.delete_all

csv_path = Rails.root.join('data', 'mercasa-2026-normalizado.csv')

# Month code to name mapping
month_map = {
  '03' => 'Mar', '05' => 'May', '07' => 'Jul', '08' => 'Aug',
  '10' => 'Oct', '12' => 'Dec', '14' => 'Feb', '15' => 'Mar',
  '17' => 'Apr', '19' => 'May', '20' => 'Jun', '21' => 'Jul',
  '22' => 'Aug', '24' => 'Sep', '26' => 'Oct', '27' => 'Nov',
  '28' => 'Dec', '31' => 'Jan'
}

# Collect prices by product and date_ref (daily), compute averages
aggregated = Hash.new { |h, k| h[k] = [] }

CSV.foreach(csv_path, headers: true) do |row|
  product = row['product']
  date_ref = row['date_reference'].gsub('*', '')
  day = date_ref.split('/')[0]
  month_code = date_ref.split('/')[1] rescue next
  month_name = month_map[month_code]
  next unless month_name

  # European decimal format: 2,80 -> 2.80
  price_str = row['price_eur_kg'].to_s.gsub(',', '.').strip
  price = price_str.to_f
  next if price.zero?

  # Key by product + date_ref for daily aggregation
  key = "#{product}:#{date_ref}"
  aggregated[key] << price
end

# Create Price records with daily averages
aggregated.each do |key, prices|
  product, date_ref = key.split(':')
  day = date_ref.split('/')[0]
  month_code = date_ref.split('/')[1]
  month_name = month_map[month_code]
  avg_price = prices.sum / prices.size

  Price.find_or_create_by!(
    item: product,
    day: day,
    month: month_name,
    unit: 'EUR/kg'
  ) do |p|
    p.price = avg_price.round(2)
    p.recorded_at = Time.zone.local(2026, month_code.to_i, day.to_i)
  end
end

puts "Created #{Price.count} price records from Mercasa data"
puts "Products: #{Price.pluck(:item).uniq.join(', ')}"
puts "Date range: #{Price.minimum(:day)}/#{Price.first.month} - #{Price.maximum(:day)}/#{Price.last.month}"
puts "Price range: €#{Price.minimum(:price)} - €#{Price.maximum(:price)}/kg"