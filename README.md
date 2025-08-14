# Bike Store SQL Demo (Cloud SQL + Power BI Service)

**One-week portfolio project** that demonstrates practical SQL engineering on the **Bike Store** dataset:
- **MySQL (Cloud SQL)** relational model with constraints and indexes
- **Analysis-ready views** (joins, CTEs, window functions)
- A **Power BI Service** dashboard (web) consumers can click
- Optional **T-SQL** slice (SQL Server in Docker) to show Microsoft-stack fluency

> Live dashboard: [link](https://app.powerbi.com/...)  
> ERD: see `/docs/ERD.png` • Data dictionary: `/docs/data_dictionary.md`

---

## 1) Problem & goals

Retail stakeholders want fast answers to:
- What are revenue and orders over time?
- Which categories, brands, and products drive sales?
- Which stores and staff perform best?
- Are current stocks aligned with recent demand?

**Goal:** Build a clean warehouse-style schema, curated views, and a shareable dashboard that answers these questions.

---

## 2) Dataset

**Bike Store Sample Database** (Kaggle). Tables include:
`customers, staffs, stores, orders, order_items, products, categories, brands, stocks`.

- Source: Kaggle (public sample)
- Grain: Order header (orders), line items (order_items)
- Time column: e.g., `order_date`
- Geography: store/city/state

See `/docs/data_dictionary.md` for column descriptions.

---

## 3) Architecture (high level)

