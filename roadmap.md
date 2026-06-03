# Roadmap: Fresh Market Prices MVP

## Milestones

### Milestone 1 — Current Prototype ✅
**Goal:** Basic working visualization (already done)

- [x] Single HTML file with Chart.js
- [x] Embedded CSV data (Apples, Tomatoes, Milk)
- [x] Responsive design with fresh food styling
- [x] GitHub Pages deployment

---

### Milestone 2 — Auto-Refresh Data Pipeline 🛠
**Goal:** Data updates weekly without manual intervention

- [ ] Define data source (API, spreadsheet, etc.)
- [ ] Build GitHub Actions cron workflow to fetch and commit new CSV data
- [ ] Add graceful failure handling (notify if source unavailable)
- [ ] Document the data update process in README

**Estimated effort:** 2–3 days

---

### Milestone 3 — Documentation Page
**Goal:** Render PRD and roadmap as part of the website

- [ ] Create `/docs/index.html` with rendered PRD + roadmap
- [ ] Add navigation between main chart and docs pages
- [ ] Include changelog / version history

**Estimated effort:** 1 day

---

### Milestone 4 — GitHub Project Board
**Goal:** Organize tasks, track progress, assign work

- [ ] Create GitHub Project (Kanban board)
- [ ] Add issues for each open task from Milestones 2–3
- [ ] Set up labels and milestones
- [ ] Enable GitHub Actions integration for automated status updates

**Estimated effort:** 0.5 day

---

## Task Summary

| # | Task | Milestone | Status | Notes |
|---|------|-----------|--------|-------|
| 1 | Define data source | 2 | 🔴 Todo | Need to pick a source |
| 2 | Build cron workflow | 2 | 🔴 Todo | curl/wget + commit |
| 3 | Add failure notifications | 2 | 🔴 Todo | Slack/email on failure |
| 4 | Write README for data | 2 | 🔴 Todo | Document source & process |
| 5 | Render docs page | 3 | 🔴 Todo | /docs page with MD content |
| 6 | Add nav between pages | 3 | 🔴 Todo | Header links |
| 7 | Create GitHub Project | 4 | 🔴 Todo | Kanban board |
| 8 | Add issues for tasks | 4 | 🔴 Todo | One issue per open task |

## Next Action

**Start Milestone 2, Task 1:** Choose a data source for weekly price updates.

Options:
- A. Public API (e.g., USDA, market data providers)
- B. Google Sheets export (manual or automated)
- C. Simulated data (for demo purposes)
- D. Custom script output