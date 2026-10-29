# WorldQuant BRAIN Alpha Log

A weekly log of the alphas I build on WorldQuant BRAIN.
For each alpha I record the **idea → settings → results → why it behaved that way**.

- Platform: [WorldQuant BRAIN](https://platform.worldquantbrain.com/)
- Default setup: USA · D1 · TOP3000 (noted per week if different)
- Status: tutorial complete — **Gold level reached (10,000 Challenge points)**, 7 alphas submitted

## Weekly reports

| Week | Topic | Simulations | Best alpha | Key takeaway | Report |
|---|---|---|---|---|---|
| [Week 1](week01/README.md) | Tutorial Ch.1–2: reversion, momentum, first submission | ~30 | Reversal + fundamentals blend (Sharpe 2.46, submitted) | Price–volume signals alone struggle to pass submission checks; blending signals with different horizons covers each other's weak years | [PDF](week01/week01_report.pdf) |
| [Week 2](week02/README.md) | Tutorial Ch.3–4: fundamental and option alphas | 19 | Option IV gap + earnings-yield blend (Sharpe 2.49, submitted) | Compare a company with its own past (`ts_rank`), not just with peers; read failed checks before tuning | [PDF](week02/week02_report.pdf) |
| [Week 3](week03/README.md) | Tutorial Ch.5: sentiment & news alphas | 4 | News-conditioned momentum / reversal (Sharpe 1.91, submitted) | Read yearly results, not just the total (sentiment flipped in 2022); collapse vector data with `vec_avg` first | [PDF](week03/week03_report.pdf) |
| [Week 4](week04/README.md) | Tutorial Ch.6: expanding ideas, reaching **Gold** | 21 | Option IV gap + liability fair value + leverage (Sharpe 1.90, Fitness 1.81, submitted) | A better variant is not a submittable one (self-correlation); new ideas are weak alone but pass when blended | [PDF](week04/week04_report.pdf) |

## Best alphas so far

| Week | Idea | Neutralization / Decay | Sharpe | Fitness | Turnover | Status |
|---|---|---|---|---|---|---|
| 2 | Call–put IV gap (volatility-bucket neutralized) + earnings-yield time-series rank | Subindustry / 4 | 2.49 | 1.69 | 24.44% | Submitted (ACTIVE) |
| 1 | Short-term reversal + profitability, 50:50 | Industry / 10 | 2.46 | 1.91 | 18.96% | Submitted (ACTIVE) |
| 3 | News-conditioned momentum / reversal | Subindustry / 8 | 1.91 | 1.25 | 16.08% | Submitted (ACTIVE) |
| 4 | Option IV gap + liability fair value + leverage | Subindustry / 8 | 1.90 | 1.81 | 11.67% | Submitted (ACTIVE) |
| 4 | Leverage (low equity-to-assets) | Subindustry / 4 | 1.55 | 1.28 | 1.68% | Submitted (ACTIVE) |
| 4 | Analyst-revision reversal + financial health | Industry / 8 | 1.34 | 1.10 | 3.70% | Submitted (ACTIVE) |
| 2 | Earnings-yield time-series rank, TOP200 | Subindustry / 4 | 1.64 | 1.76 | 9.43% | Submitted (ACTIVE) |
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
