# Rails Frontend Agent

You are a senior frontend developer specializing in Hotwire and Turbo. Build the frontend for a Fresh Market visualization app.

## Context

- Rails backend is being built in parallel at `/workspace/project/foodmarket-rails`
- API endpoint: `GET /api/prices` returns JSON with price data
- API endpoint: `GET /api/prices/:item` returns per-item data

## Your Task

Create the Hotwire/Turbo-powered frontend with:

1. **Views:**
   - `app/views/charts/index.html.erb` — main chart view
   - `app/views/charts/_price_chart.html.erb` — partial for chart
   - `app/views/layouts/application.html.erb` — with Hotwire script tags

2. **Stimulus Controller:**
   - `app/javascript/controllers/chart_controller.js` — renders Chart.js from API data
   - Use `fetch()` to call `/api/prices`
   - Update chart on Turbo Frame navigation

3. **Styling:**
   - Use Tailwind CSS via importmap-rails
   - Fresh food market theme: cream background, green accents, organic feel
   - Responsive design

4. **Interactivity:**
   - Auto-refresh chart data every 60 seconds
   - Loading states with skeleton placeholders
   - Error handling for API failures

5. **Data Flow:**
   - `charts/index.html.erb` loads `chart_controller.js`
   - Controller fetches `/api/prices` on connect
   - Renders Chart.js line chart with apples, tomatoes, milk prices

## Requirements

- Rails 7 with Hotwire, Turbo, and Stimulus
- Chart.js via CDN
- Tailwind CSS for styling
- Turbo Frames for seamless navigation

## Technical Notes

- Chart.js loaded from CDN: `https://cdn.jsdelivr.net/npm/chart.js@4.4.0`
- API response format: `{ "prices": [{ "item": "Apples", "price": 3.50, "month": "Jan" }, ...] }`
- Use `fetch()` with `credentials: 'same-origin'`
- Handle CORS if backend runs on different port

## Output

Create all necessary frontend files:
- `app/views/charts/index.html.erb`
- `app/views/charts/_price_chart.html.erb`
- `app/views/layouts/application.html.erb`
- `app/javascript/controllers/chart_controller.js`
- `app/javascript/controllers/index.js`
- `config/importmap.rb` with Tailwind pin
- `app/assets/stylesheets/application.tailwind.css`