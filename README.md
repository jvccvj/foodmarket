# Fresh Market Prices

A Rails 7 + Hotwire application for visualizing fresh food prices with real Mercasa data.

## Quick Demo (Static HTML)

Open `index.html` in a browser — it's a standalone Chart.js demo with the same data.

**Live:** https://jvccvj.github.io/foodmarket/

## Rails App

For full Hotwire/Turbo functionality:

```bash
# Install dependencies
bundle install

# Create database and seed data
rails db:create db:migrate db:seed

# Start server
rails server
```

Visit http://localhost:3000

## Data Source

Prices from **Mercasa** (Spanish wholesale markets):
- **Cerezas** (Cherries): 7 daily records (May 2026)
- **Fresones** (Strawberries): 12 daily records (Mar-Apr 2026)

Markets: Mercamadrid, Mercabarna, Mercabilbao, Mercasevilla, Mercavalencia

## Tech Stack

- **Rails 7** with API mode
- **Hotwire** (Turbo + Stimulus)
- **Chart.js** for visualizations
- **SQLite** database
- **GitHub Pages** for static demo