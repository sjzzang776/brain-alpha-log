# Week 3: Sentiment & News Alphas

- Dates: 2026-10-20 (midterm week)
- Scope: BRAIN Tutorial Chapter 5 — Sentiment & News Alphas (3/3 complete)
- Simulations: 4, 1 submitted (6 in total so far)
- Common settings: USA · D1 · TOP3000 · Subindustry · Truncation 0.08 · NaN handling On · Test period 0 (full in-sample period)

> Chapter 6 (reaching 10,000 Challenge points) is next week's scope. Work I started on it early will be written up in week 4.

## Summary

Chapter 5 introduced two new kinds of data: **social-media sentiment** (how much a stock is talked about online) and **news** (whether going long or short paid off after each news release).
The sentiment signal looked mediocre overall but hid a regime change: it worked strongly through 2021 and then flipped direction.
News data is stored as *vectors* — several items per stock per day — so it has to be collapsed with `vec_avg` before regular operators apply. After that, a single conditional expression switching between momentum and reversal produced a stable alpha, which I submitted.

## Roadmap

```
Step 1  social buzz vs volume (ts_regression)    Sharpe -1.06 → flipped 1.06, direction reverses in 2022
Step 2  news "long-favoured" → momentum, else 5-day reversal
                                                  Sharpe 1.95, Fitness 1.12 (Decay 4)
Step 3  same with Decay 8                         Sharpe 1.91, Fitness 1.25  --> SUBMITTED
```

---

## 1. Sentiment: social buzz versus trading volume

**Idea:** if a stock is discussed online far more than its trading volume would suggest, attention may be overheated.

`ts_regression(y, x, d)` fits a line of `y` on `x` over the last `d` days and returns the residual — here, "how much more buzz than volume explains". `scl12_buzz` measures how much a stock is mentioned online.

| Expression | Sharpe | 2019 | 2020 | 2021 | 2022 | 2023 |
|---|---|---|---|---|---|---|
| `ts_regression(scl12_buzz, volume, 250)` | -1.06 | -2.20 | -2.79 | -3.00 | +0.75 | +1.90 |
| `-ts_regression(scl12_buzz, volume, 250)` | 1.06 | **+2.20** | **+2.79** | **+3.00** | -0.75 | -1.90 |

As the tutorial suggests, I flipped the sign when the direction was wrong. The flipped signal was very strong through 2021 (excess attention → price falls) and then **reversed from 2022**. The aggregate Sharpe of 1.06 hides this; only the yearly table shows it. It also failed the checks (56% turnover, one-day weight concentration, weak sub-universe), so I moved on.

![](img/02_buzz_regression.jpg)

## 2. News: vector data and a conditional alpha

News data covers earnings reports, analyst calls, product approvals and legal events. US news mostly comes out in the pre-market (4:00–9:30) or after-hours (16:00–20:00) sessions.

Because one stock can have several news items per day, the fields are **vectors**: one cell holds several values. Regular operators expect one value per stock per day, so a `vec_` operator such as `vec_avg` must collapse each day's items first.

![Vector data must be collapsed into a matrix before regular operators apply (tutorial figure)](img/03_vector_data.png)

`nws12_afterhsz_sl` tells whether going long or short was more profitable after each news release.

**Idea:** stocks whose recent news favoured longs show momentum; the rest tend to revert. Following the tutorial's recipe:

1. average each day's news values with `vec_avg`
2. smooth with a 60-day `ts_mean` to reduce daily noise
3. split the universe in half with `rank(...) > 0.5`
4. top half → constant long (the condition already captures momentum); bottom half → 5-day price reversal, joined with a conditional `? :`

| Version | Sharpe | Turnover | Fitness | Drawdown | Margin |
|---|---|---|---|---|---|
| Decay 4 (tutorial step 2) | 1.95 | 22.73% | 1.12 | 3.25% | 6.58 bps |
| **Decay 8** (step 3) | 1.91 | **16.08%** | **1.25** | 3.02% | **8.60 bps** |

Yearly Sharpe for the Decay 4 version: 2.74 / 4.19 / 1.72 / 0.22 / 1.92. Fitness was close to the 1.0 cutoff, so — as in week 1 — I raised Decay: turnover fell by a third with almost no loss of Sharpe.

### Submitted: news momentum / reversal ✓

| Item | Detail |
|---|---|
| Chapter | Chapter 5, Step 3 |
| Operators | `vec_avg`, `ts_mean`, `rank`, `ts_delta`, conditional `? :` |
| Data fields | `nws12_afterhsz_sl`, `close` |
| Settings | USA · TOP3000 · Delay 1 · Subindustry · Decay 8 |
| Result (2019–2023) | **Sharpe 1.91 · Fitness 1.25 · Turnover 16.08%** · Returns 6.92% · Drawdown 3.02% |
| Checks | 8 passed. Sub-universe Sharpe 1.35, self-correlation 0.32 |

> For submitted alphas I share the idea, operators and data fields, but not the exact expression.

![](img/04_news_alpha.jpg)
![](img/04_news_checks.jpg)
![Cumulative PnL](img/04_news_pnl.jpg)

---

## What I learned this week

1. **Read the yearly table, not just the total.** The sentiment signal's Sharpe of 1.06 hid a sign flip in 2022.
2. **Flip a signal only when it is consistently wrong.** Flipping fixes a reversed direction, not a regime change.
3. **Shape the data first.** Vector data needs `vec_avg` before `ts_mean`, `rank` and the rest.
4. **One condition can combine two strategies.** News decides whether a stock gets the momentum leg or the reversal leg.
5. **When fitness is borderline, raise Decay.** 22.7% → 16.1% turnover lifted fitness from 1.12 to 1.25.

## Next week

- Chapter 6: submit more alphas until the Challenge score reaches 10,000 (Gold)
- Look for new ingredients rather than variations of submitted alphas, since near-copies fail the self-correlation check

## All experiments

| # | Idea | Decay | Sharpe | Turnover | Fitness | Note |
|---|---|---|---|---|---|---|
| 1 | Buzz vs volume regression (250 days) | 4 | -1.06 | 56.13% | -0.46 | wrong direction |
| 2 | #1 reversed | 4 | 1.06 | 56.13% | 0.46 | flips in 2022 |
| 3 | News-conditioned momentum / reversal | 4 | 1.95 | 22.73% | 1.12 | 8 checks passed |
| 4 | #3 with Decay 8 | 8 | 1.91 | 16.08% | 1.25 | submitted |
