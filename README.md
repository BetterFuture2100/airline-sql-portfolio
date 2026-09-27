# Commercial Airline Flight Delay & Reliability Analysis (SQL / PostgreSQL)

## Project Overview
This project delivers an end-to-end exploratory and operational analysis of domestic flight performance using a star-schema analytical database in PostgreSQL. The investigation focuses on arrival delay behavior, route distance dynamics, delay benchmarking, cancellation root causes, and carrier-level punctuality rankings.

---

## Data Architecture
The data warehouse utilizes a star-schema design centered around operational flight facts:

* **`flights_fact`**: Fact table storing individual flight records, scheduled/actual timings, distance, cancellation flags, and delay durations (`arr_delay`, `dep_delay`).
* **`carriers_dim`**: Airline dimension mapping operational codes to commercial airline names (`carrier_code`, `carrier_name`).
* **`airports_dim`**: Geographical airport master dimension (`airport_code`, `airport_name`, `city`, `state`).
* **`cancellations_dim`**: Dimension decoding cancellation categorizations (`cancel_code`, `cancel_reason`).

---

## Analytical Queries & Technical Skills

| Script | Business Objective | Core SQL Techniques |
| :--- | :--- | :--- |
| `sql/01_delay_distribution.sql` | Segment flights into punctuality tiers (On-Time, Minor, Moderate, Severe). | `CASE WHEN`, `COUNT()`, Aggregate Windowing |
| `sql/02_longest_routes.sql` | Identify the longest domestic flight corridors. | Role-Playing Dimension Joins, `DISTINCT`, `ORDER BY` |
| `sql/03_delay_benchmark.sql` | Flag underperforming airlines exceeding the national average delay. | Scalar Subquery in `HAVING`, Explicit Casting (`::NUMERIC`) |
| `sql/04_cancellation_causes.sql` | Analyze primary drivers of flight cancellations per carrier. | Derived Tables (Subquery in `FROM`), Multi-Table `JOIN` |
| `sql/05_airline_rankings.sql` | Establish carrier punctuality leaderboard based on average arrival delay. | Common Table Expressions (CTE), `DENSE_RANK() OVER()` |

---

## Key Findings
* **Carrier Punctuality:** Regional carriers (e.g., Republic Airways) demonstrated superior on-time performance (averaging negative arrival delays / early arrivals), whereas major legacy network carriers showed higher delay variance due to hub congestion.
* **National Benchmark:** Several high-volume carriers consistently exceeded the aggregate national arrival delay threshold, driven by cascading turnaround delays on high-frequency corridors.
* **Cancellation Drivers:** Weather-related cancellations represent the largest absolute share of disruptions, followed by carrier-controlled operational bottlenecks.

---

## Repository Structure
```text
airline-sql-portfolio/
│
├── sql/
│   ├── 01_delay_distribution.sql
│   ├── 02_longest_routes.sql
│   ├── 03_delay_benchmark.sql
│   ├── 04_cancellation_causes.sql
│   └── 05_airline_rankings.sql
│
├── .gitignore
└── README.md