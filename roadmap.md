# Fresh Market — Project Log

## API Investigation: OpenFoodFacts

**Date:** 2026-06-03
**Goal:** Find real price data via https://world.openfoodfacts.org/data
**Status:** ❌ Not applicable — no price field available

### Test Request

```
GET https://world.openfoodfacts.org/cgi/search.pl?search_terms=apple&json=1&page_size=5&fields=product_name,brands,nutriscore_grade,ecoscore_grade
```

### Available Fields

| Field | Available | Notes |
|-------|-----------|-------|
| product_name | ✅ | e.g., "Pom'Potes Bio - Pomme Bio" |
| brands | ✅ | e.g., "Materne", "Andros" |
| categories | ✅ | Hierarchical tags |
| nutriscore_grade | ✅ | a, b, c, d, e |
| ecoscore_grade | ✅ | a to f + a-plus |
| price | ❌ | **Not available** |
| price_history | ❌ | **Not available** |

### Sample Apple Products Returned

| Name | Brand | Nutriscore | Ecoscore |
|------|-------|------------|----------|
| Pom'Potes Bio - Pomme Bio | Materne | a | a-plus |
| Purée Pomme Poire Williams | Jardin Bio | a | a-plus |
| Compote de pomme allégée | Andros | a | a |

### Conclusion

OpenFoodFacts is a **nutrition/sustainability database**, not a price database. It tracks:
- Nutriscore grades (A-E health rating)
- Ecoscore ratings (environmental impact)
- Nutritional data per 100g
- Product categorization

**Not suitable for:** Price trend charts.

**Alternatives for real price data (future investigation):**
- USDA Market News API
- Bureau of Labor Statistics CPI data
- Government open data portals

### Decision

Keep simulated data approach for MVP. The `refresh.yml` workflow generates realistic weekly price fluctuations for Apples, Tomatoes, and Milk — sufficient for MVP demonstration.

---

## Rails App Investigation

**Date:** 2026-06-03
**Goal:** Rebuild prototype with Rails + Hotwire/Turbo
**Status:** ✅ Structure created — awaiting Ruby environment

### Agent Setup

Two file-based agents created in parallel:

| Agent | Role | Files Created |
|-------|------|---------------|
| `rails-backend.md` | Senior Rails Developer | Model, migration, API controller, seeds |
| `rails-frontend.md` | Hotwire Specialist | Views, Stimulus, Chart.js |

### Rails App Structure

```
/workspace/project/foodmarket-rails/
├── Gemfile
├── README.md
├── config/
│   ├── routes.rb
│   └── importmap.rb
├── app/
│   ├── controllers/
│   │   ├── api/prices_controller.rb
│   │   └── charts_controller.rb
│   ├── models/price.rb
│   ├── views/charts/index.html.erb
│   └── javascript/controllers/
│       ├── index.js
│       └── chart_controller.js
└── db/
    ├── migrate/20250603000001_create_prices.rb
    └── seeds.rb
```

### API Response

```json
GET /api/prices
{
  "prices": [
    {"id": 1, "item": "Apples", "price": 3.50, "unit": "USD/kg", "month": "Jan", "recorded_at": "2026-06-03T12:00:00Z"},
    ...
  ]
}
```

### Next Steps (when Ruby available)

```bash
cd /workspace/project/foodmarket-rails
bundle install
rails db:create db:migrate db:seed
rails server
```

Full log: `rails-agent-log.md`

---

## Architecture

- **Frontend:** Single HTML file with Chart.js (no build step)
- **Hosting:** GitHub Pages
- **Data refresh:** Weekly cron via `.github/workflows/refresh.yml`
- **Documentation:** `docs.html` (rendered), `prd-mvp.md`, `roadmap.md`

## Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `deploy.yml` | push to main | Deploy to GitHub Pages |
| `refresh.yml` | every Monday 00:00 UTC + manual | Generate new CSV data, commit, push |

---

## Mercasa Data Integration

**Date:** 2026-06-03
**Source:** `/workspace/mercasa-2026-normalizado.csv`
**Status:** ✅ Real data loaded

### Dataset

| Field | Description |
|-------|-------------|
| Source | Mercasa (Spanish wholesale food markets) |
| Products | Cerezas (Cherries), Fresones (Strawberries) |
| Markets | Mercamadrid, Mercabarna, Mercabilbao, Mercasevilla, Mercavalencia |
| Date range | Jan–Dec 2026 |
| Price unit | EUR/kg |

### Aggregated Prices

| Product | Month | Avg Price (EUR/kg) | Source records |
|---------|-------|-------------------|----------------|
| Cerezas | May | 2.33 | ~50 records across 5 markets |
| Fresones | Mar | 1.66 | ~40 records across 5 markets |

### Implementation

- **Rails seeds:** `db/seeds.rb` now loads CSV, computes monthly averages
- **Demo page:** `ror.html` updated with real Mercasa data
- **Data file:** `/workspace/project/foodmarket-rails/data/mercasa-2026-normalizado.csv`

### CSV Format (European decimal notation)

```csv
source,product,market,date_observed,date_reference,price_eur_kg,year,seasonal_flag,notes
Mercasa,Cerezas,Mercamadrid,22/05*,26/05*,"2,80",2026,1,
```

Note: Prices use `,` as decimal separator (2,80 = €2.80)