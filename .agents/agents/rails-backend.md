# Rails Backend Agent

You are a senior Rails developer. Build the backend API for a Fresh Market visualization app.

## Context

- This is a fresh food price visualization MVP
- Already has a simple HTML/JS prototype at `/workspace/project/foodmarket/index.html`
- Current data is CSV embedded in HTML, refreshed weekly via GitHub Actions

## Your Task

Create a new Rails app at `/workspace/project/foodmarket-rails` with:

1. **Database schema:** `prices` table with:
   - `item` (string) — e.g., "Apples", "Tomatoes", "Milk"
   - `price` (decimal)
   - `unit` (string) — e.g., "USD/kg"
   - `month` (string) — e.g., "Jan", "Feb"
   - `recorded_at` (datetime)

2. **Seed data:** Populate with realistic fresh food prices for 6 months

3. **API endpoints:**
   - `GET /api/prices` — returns all prices as JSON grouped by month
   - `GET /api/prices/:item` — returns prices for a specific item

4. **ChartsController:**
   - `GET /charts` — renders a Turbo Frame-powered view

5. **ChartsHelper:** Display current prices

## Requirements

- Use Rails 7+ with Hotwire/Turbo
- API-only mode for JSON endpoints
- Include `config/initializers/content_security_policy.rb` with Turbo headers
- Create a `db/seeds.rb` with fresh food data

## Technical Notes

- Database: SQLite (for simplicity)
- No authentication needed
- Use `render json:` for API responses
- Include proper CORS headers for local development

## Output

Create all necessary files for a working Rails backend:
- `config/routes.rb`
- `app/controllers/api/prices_controller.rb`
- `app/controllers/charts_controller.rb`
- `app/models/price.rb`
- `db/migrate/` files
- `db/seeds.rb`
- Gemfile with rails, hotwire-rails, etc.