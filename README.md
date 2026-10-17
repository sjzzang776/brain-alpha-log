# WorldQuant BRAIN Alpha Log

A weekly log of the alphas I build on WorldQuant BRAIN.
For each alpha I record the **idea → settings → results → why it behaved that way**.

- Platform: [WorldQuant BRAIN](https://platform.worldquantbrain.com/)
- Default setup: USA · D1 · TOP3000 (noted per week if different)

## Weekly reports

| Week | Topic | Simulations | Best alpha | Key takeaway | Report |
|---|---|---|---|---|---|
| [Week 1](week01/README.md) | Tutorial Ch.1–2: reversion, momentum, first submission | ~30 | Reversal + fundamentals blend (Sharpe 2.46, submitted) | Price–volume signals alone struggle to pass submission checks; blending signals with different horizons covers each other's weak years | [PDF](week01/week01_report.pdf) |

## Best alphas so far

| Week | Idea | Neutralization / Decay | Sharpe | Fitness | Turnover | Status |
|---|---|---|---|---|---|---|
| 1 | Short-term reversal + profitability, 50:50 | Industry / 10 | 2.46 | 1.91 | 18.96% | Submitted (ACTIVE) |
| 1 | CLV × volume reversion | Subindustry / 8 | 1.73 | 0.82 | 62.43% | Not submitted |
| 1 | Close / VWAP reversion | Subindustry / 8 | 1.62 | 0.76 | 61.49% | Not submitted |

## How to read the metrics

| Metric | Meaning | Typical target |
|---|---|---|
| Sharpe | Return ÷ volatility — how consistently the alpha makes money | ≥ 1.25 to submit (D1) |
| Turnover | How much of the portfolio changes each day | 1% – 70% |
| Fitness | Sharpe × √(\|Returns\| ÷ Turnover) — profitability adjusted for trading cost | ≥ 1.0 |
| Drawdown | Largest peak-to-trough loss | Lower is better |
| Margin | Profit per dollar traded (bps) | Higher means more robust to costs |

## Repository layout

```
weekNN/
  README.md          write-up for the week
  weekNN_report.pdf  same write-up as a PDF
  img/               result screenshots
_template.md         template for a new week
```

> For submitted alphas I share the idea, operators and data fields, but not the exact expression.
