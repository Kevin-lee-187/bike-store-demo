# Bike Store SQL Demo (Cloud SQL + Power BI Service)

**One-week portfolio project** that demonstrates practical SQL engineering on the **Bike Store** dataset:

* **MySQL (Cloud SQL)** relational model with constraints and indexes
* **Analysis-ready views** (joins, CTEs, window functions)
* A **Power BI Service** dashboard (web) consumers can click
* Optional **T-SQL** slice (SQL Server in Docker) to show Microsoft-stack fluency

> Live dashboard: [link to be added]  
> ERD: see `/docs/ERD.png` • Data dictionary: `/docs/data_dictionary.md`

---

## 1) Problem & goals

Retail stakeholders want fast answers to:

* What are revenue and orders over time?
* Which categories, brands, and products drive sales?
* Which stores and staff perform best?
* Are current stocks aligned with recent demand?

**Goal:** Build a clean warehouse-style schema, curated views, and a shareable dashboard that answers these questions.

---

## 2) Dataset

**Bike Store Sample Database** (Kaggle). Tables include: `customers`, `staffs`, `stores`, `orders`, `order_items`, `products`, `categories`, `brands`, `stocks`.

* Source: Kaggle (public sample)
* Grain: Order header (orders), line items (order_items)
* Time column: e.g., `order_date`
* Geography: store/city/state

See `/docs/data_dictionary.md` for column descriptions.

---

## 3) Architecture (high level)

<<<<<<< HEAD
### Database Schema
- **Production Schema**: `brands`, `categories`, `products`, `stocks`
- **Sales Schema**: `customers`, `staffs`, `stores`, `orders`, `order_items`

### Key Features
- Proper foreign key constraints and referential integrity
- Optimized indexes for query performance
- Data validation and constraints
- Bulk data loading capabilities

---

## 4) Quick Start

### Prerequisites
- MySQL 8.0+ (Cloud SQL recommended)
- Cloud SQL Proxy for local development
- MySQL client with LOCAL INFILE support

### Setup
1. **Connect to Cloud SQL via proxy:**
   ```bash
   cloud-sql-proxy --port=3307 YOUR_INSTANCE_CONNECTION_NAME
   ```

2. **Create database and tables:**
   ```bash
   mysql --host=127.0.0.1 --port=3307 -u YOUR_USER -p --local-infile=1
   ```
   
   Then run the SQL scripts in `/sql/` directory.

3. **Load sample data:**
   ```bash
   # Use the bulk_Load_CSVs.sql script
   source /path/to/sql/bulk_Load_CSVs.sql
   ```

---

## 5) Project Structure

```
demo_playground/
├── data/           # CSV data files
├── ddl/            # Data Definition Language scripts
├── dml/            # Data Manipulation Language scripts
├── docs/           # Documentation and ERD
├── etl/            # Extract, Transform, Load scripts
├── ops/            # Operations and maintenance scripts
├── report/         # Reporting and analytics scripts
├── sql/            # Main SQL scripts including bulk loading
└── tsql/           # T-SQL scripts for SQL Server
```

---

## 6) Key SQL Scripts

- **`sql/bulk_Load_CSVs.sql`**: Complete database setup and data loading
- **`ddl/`**: Table creation and schema definition
- **`dml/`**: Data manipulation and sample queries
- **`report/`**: Business intelligence and analytics queries

---

## 7) Data Model

The database follows a normalized design with clear separation between:
- **Product Management**: brands, categories, products, stocks
- **Sales Operations**: customers, orders, order_items, staffs, stores

All relationships maintain referential integrity with appropriate foreign key constraints.

---

## 8) Contributing

This is a portfolio project demonstrating SQL engineering skills. Feel free to fork and extend with additional features like:
- Advanced analytics queries
- Performance optimization
- Additional data sources
- Enhanced reporting

---

## 9) License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 10) Contact

- GitHub: [@Kevin-lee-187](https://github.com/Kevin-lee-187)
- Project: [bike-store-demo](https://github.com/Kevin-lee-187/bike-store-demo)
>>>>>>> 9df59cd66100fe90c0575c335b5f5d2a2d5abd4c
