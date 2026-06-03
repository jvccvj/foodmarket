# Fresh Market Rails

A Rails 7 application with Hotwire/Turbo for visualizing fresh food prices.

Built with real data from **Mercasa** (Spanish wholesale markets).

## Tech Stack

- **Rails 7** with API mode
- **Hotwire** (Turbo + Stimulus)
- **Chart.js** for visualizations
- **Tailwind CSS** via importmap
- **SQLite** database

## Setup

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

Prices are sourced from Mercasa CSV data (`data/mercasa-2026-normalizado.csv`):
- **Cerezas** (Cherries): 7 daily records (May 2026)
- **Fresones** (Strawberries): 12 daily records (Mar-Apr 2026)

Prices are aggregated as daily averages across 5 Spanish wholesale markets:
Mercamadrid, Mercabarna, Mercabilbao, Mercasevilla, Mercavalencia.

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/prices` | GET | All prices as JSON |
| `/api/prices/:id` | GET | Single price record |
| `/charts` | GET | Chart view (Turbo frame) |
| `/` | GET | Root → charts |

## Features

- **Auto-refresh**: Chart data refreshes every 60 seconds via Stimulus
- **Loading states**: Skeleton placeholders while fetching
- **Responsive**: Works on mobile and desktop
- **Real-time**: Hotwire Turbo frames for seamless updates
- **Real data**: Aggregated daily prices from Mercasa wholesale markets