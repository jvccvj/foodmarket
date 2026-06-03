# Fresh Market Prices 🍎

A Rails 7 + Hotwire application for visualizing fresh food wholesale market prices with real data from **Mercasa** (Spain).

## Live Demo

**Static:** https://jvccvj.github.io/foodmarket/

## Quick Start (Static HTML)

For a quick preview, open `index.html` in your browser. It contains a standalone Chart.js demo with all the same Mercasa data.

```bash
open index.html  # macOS
# or just double-click the file
```

## Rails App (Full Hotwire/Turbo)

```bash
# Install dependencies
bundle install

# Create database and seed with Mercasa data
rails db:create db:migrate db:seed

# Start development server
rails server
```

Visit http://localhost:3000

## Data Source

Prices sourced from **Mercasa** (Spanish wholesale food markets network):

| Product | Name | Records | Period |
|---------|------|---------|--------|
| 🍒 Cerezas | Cherries | 7 daily | May 2026 |
| 🍓 Fresones | Strawberries | 12 daily | Mar-Apr 2026 |

**Markets:** Mercamadrid, Mercabarna, Mercabilbao, Mercasevilla, Mercavalencia

**Unit:** EUR/kg (daily average across 5 wholesale markets)

## Project Structure

```
├── index.html              # Standalone Chart.js demo (GitHub Pages)
├── Gemfile                 # Rails dependencies
├── app/
│   ├── controllers/        # API + Charts controllers
│   ├── models/price.rb     # Price data model
│   └── views/             # Hotwire/Turbo views
├── config/
│   └── routes.rb          # API and page routes
├── data/
│   └── mercasa-2026-normalizado.csv  # Source data
├── db/
│   ├── migrate/           # Database schema
│   └── seeds.rb           # Data import
└── test/                  # Unit, integration, system tests
```

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/prices` | GET | All prices as JSON |
| `/api/prices/:id` | GET | Single price record |
| `/charts` | GET | Chart view (Turbo frame) |
| `/` | GET | Root → charts |

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Rails 7 (API mode) |
| Frontend | Hotwire + Turbo + Stimulus |
| Charts | Chart.js |
| Database | SQLite |
| Deployment | GitHub Pages (static) / Railway (Rails) |

## Running Tests

```bash
# Run all tests
rails test

# Run specific test types
rails test:test/models       # Unit tests
rails test:test/integration  # API integration tests
rails test:test/system       # End-to-end browser tests
```

### Test Coverage

- **Model tests:** Validation, uniqueness, required fields
- **Integration tests:** API endpoints, JSON responses, error handling
- **System tests:** Chart rendering, table display, product visibility
- **Seeds tests:** CSV parsing, European decimal format, data aggregation

## Architecture Notes

### Data Flow

```
mercasa-2026-normalizado.csv
        ↓ (seeds.rb)
    SQLite database
        ↓ (API)
    JSON response
        ↓ (Stimulus)
    Chart.js visualization
```

### CSV Format

The source data uses European decimal format (comma separator):

```csv
date_reference,market,product,price_eur_kg
05/05/2026,Mercamadrid,Cerezas,"2,43"
```

Seeds parse this and convert to standard Float for storage.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Ensure tests pass (`rails test`)
4. Commit your changes
5. Push to the branch
6. Open a Pull Request

## License

MIT