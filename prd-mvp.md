# PRD: Fresh Market Price Visualization MVP

## Introduction

A public-facing web visualization tool that displays seasonal fresh food prices (fruits, vegetables, dairy) as an interactive line chart. Data is embedded as CSV and automatically refreshes on a weekly schedule via GitHub Actions. The tool is designed for general audiences — no context or account needed.

## Goals

- Display fresh food price trends over time in a clean, readable line chart
- Self-contained single HTML file — no backend, no build step
- Auto-refresh data weekly via GitHub Actions without manual intervention
- Accessible to general public: works in all modern browsers, responsive layout
- Shareable via a public URL (GitHub Pages)

## User Stories

### US-001: View price chart
**Description:** As a visitor, I want to open the page and immediately see a clear line chart of fresh food prices so I can understand trends at a glance.

**Acceptance Criteria:**
- [ ] Page loads with title "Fresh Market Prices" and a line chart
- [ ] Chart shows 3 lines: Apples, Tomatoes, Milk with monthly labels (Jan–Jun)
- [ ] Legend identifies each line by color
- [ ] Y-axis shows price in USD/kg

### US-002: Responsive on mobile
**Description:** As a mobile user, I want the chart to resize to fit my screen so I can read the data without horizontal scrolling.

**Acceptance Criteria:**
- [ ] Chart width adapts to viewport on screens < 600px
- [ ] Text remains readable on mobile (no overlapping labels)

### US-003: Auto-refresh data weekly
**Description:** As a site owner, I want the data to update automatically each week so the chart stays current without me manually editing it.

**Acceptance Criteria:**
- [ ] GitHub Actions workflow runs weekly (cron: every Monday 00:00 UTC)
- [ ] Workflow updates the CSV data in index.html with new values
- [ ] Workflow commits and pushes changes to main
- [ ] GitHub Pages redeploys after the workflow completes

### US-004: Readable metadata
**Description:** As a visitor, I want to see units, date range, and source context so I understand what the data represents.

**Acceptance Criteria:**
- [ ] Footer shows "Prices in USD/kg | Jan–Jun 2024" with relevant emojis
- [ ] Chart has axis labels ("Price (USD/kg)" on Y, months on X)

## Functional Requirements

- FR-1: Single `index.html` file containing all CSS, JS (Chart.js), and data
- FR-2: Line chart rendered via Chart.js 4.x from CDN
- FR-3: CSV data embedded as a JS template literal variable
- FR-4: GitHub Actions workflow runs on cron schedule `0 0 * * 1` (weekly Monday)
- FR-5: Workflow fetches data from a source URL (to be defined), updates the CSV variable, commits to main
- FR-6: Responsive CSS using viewport units and max-width constraints
- FR-7: GitHub Pages serves the site at `https://[user].github.io/[repo]/`

## Non-Goals

- No user authentication or multi-user support
- No user-configurable chart options or custom data upload
- No backend, database, or API beyond data fetching in the CI workflow
- No chart types beyond line charts
- No support for IE or legacy browsers

## Technical Considerations

- Chart.js loaded from jsDelivr CDN (pinned to v4.4.0)
- Data refresh happens in CI, not client-side (no CORS issues)
- Workflow uses `curl` or `wget` to fetch fresh CSV from a public URL (placeholder for now)
- If data source is unavailable, workflow fails gracefully (no stale data committed)

## Success Metrics

- Page loads in under 2 seconds on a 3G connection
- Chart renders correctly on Chrome, Firefox, Safari, Edge (last 2 versions)
- GitHub Actions workflow completes in under 2 minutes
- Zero manual interventions needed after initial setup

## Open Questions

- Where will the weekly data be sourced from? (public API, spreadsheet export, manual uploads?)
- Should the date range be dynamic (always show last 6 months) or fixed?
- Should we track page views or other analytics?