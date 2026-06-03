import { Controller } from "@hotwired/stimulus"
import { fetch } from "@hotwired/turbo-fetch"

export default class ChartController extends Controller {
  static targets = ["canvas", "loading"]
  
  connect() {
    this.loadChart()
    // Auto-refresh every 60 seconds
    this.interval = setInterval(() => this.loadChart(), 60000)
  }
  
  disconnect() {
    if (this.interval) {
      clearInterval(this.interval)
    }
  }
  
  async loadChart() {
    try {
      this.loadingTarget?.classList.remove('hidden')
      
      const response = await fetch('/api/prices')
      const data = await response.json()
      
      this.renderChart(data.prices)
    } catch (error) {
      console.error('Failed to load chart data:', error)
    } finally {
      this.loadingTarget?.classList.add('hidden')
    }
  }
  
  renderChart(prices) {
    const ctx = this.canvasTarget.getContext('2d')
    
    const months = [...new Set(prices.map(p => p.month))].sort()
    const items = [...new Set(prices.map(p => p.item))]
    
    const colors = {
      'Apples': { border: '#c0392b', bg: 'rgba(192,57,43,0.15)' },
      'Tomatoes': { border: '#e67e22', bg: 'rgba(230,126,34,0.15)' },
      'Milk': { border: '#2980b9', bg: 'rgba(41,128,185,0.15)' }
    }
    
    const datasets = items.map(item => {
      const c = colors[item] || { border: '#666', bg: 'rgba(102,102,102,0.15)' }
      return {
        label: item,
        data: months.map(month => {
          const p = prices.find(pr => pr.item === item && pr.month === month)
          return p ? p.price : null
        }),
        borderWidth: 3,
        borderColor: c.border,
        backgroundColor: c.bg,
        pointRadius: 6,
        pointHoverRadius: 8,
        fill: true,
        tension: 0.3
      }
    })
    
    if (this.chart) {
      this.chart.data.labels = months
      this.chart.data.datasets = datasets
      this.chart.update()
    } else {
      this.chart = new window.Chart(ctx, {
        type: 'line',
        data: { labels: months, datasets },
        options: {
          responsive: true,
          plugins: {
            legend: {
              labels: { font: { family: 'Nunito', size: 14 }, color: '#2d3a2e' }
            }
          },
          scales: {
            y: {
              beginAtZero: false,
              title: {
                display: true,
                text: 'Price (USD/kg)',
                color: '#3a5f3a',
                font: { family: 'Nunito', size: 13 }
              },
              grid: { color: 'rgba(0,0,0,0.05)' },
              ticks: { color: '#6b7c6b', font: { family: 'Nunito' } }
            },
            x: {
              grid: { color: 'rgba(0,0,0,0.05)' },
              ticks: { color: '#6b7c6b', font: { family: 'Nunito' } }
            }
          }
        }
      })
    }
  }
}