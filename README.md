# Banking Transaction Monitoring, Fraud Detection & Data Warehouse

[![Database](https://img.shields.io/badge/Database-MySQL%208.0-blue.svg)](https://www.mysql.com/)
[![BI](https://img.shields.io/badge/Analytics-Power%20BI%20%7C%20DAX-yellow.svg)](https://powerbi.microsoft.com/)
[![SQL](https://img.shields.io/badge/SQL-Stored%20Procedures%20%26%20Triggers-orange.svg)]()
[![Domain](https://img.shields.io/badge/Domain-Fintech%20%26%20Digital%20Banking-green.svg)]()

An enterprise-grade relational database architecture and business intelligence system designed for real-time transaction monitoring, behavioral analytics, and fraud detection in retail banking.

---

## 📌 Project Architecture & Highlights

1. **Relational Database & Data Mart Architecture (MySQL 8.0):**
   - Normalized core banking schema: `customers`, `accounts`, `credit_cards`, `merchants`, `transactions`, and `customer_addresses`.
   - Optimized indexing strategy on composite keys `(customer_id, trans_date)` and `(merchant_id, trans_date)`.
   - Scalable transaction data mart with multi-period rollups (`customer_behavior_daily`, `weekly`, `monthly`).

2. **Automated Fraud Detection Engine:**
   - **Haversine Geospatial Velocity Check:** Custom MySQL function (`haversine_km`) calculating the spherical distance and travel velocity between successive card transactions to identify *impossible-travel fraud*.
   - **Automated Risk Flagging & Blocking:** Stored procedures (`detect_transactions`, `auto_block_transactions`) that automatically flag high-risk anomalies and transition investigation statuses (`pending` $\rightarrow$ `under review` $\rightarrow$ `closed - fraud confirmed`).
   - **Time-Feature Extraction:** Automated triggers extracting day-of-week, hour-of-day, and weekend spending indicators (`transaction_time_features`).

3. **Data Warehousing & Power BI Analytics:**
   - Star-schema data modeling connecting transaction facts with customer, account, and merchant dimensions.
   - Advanced DAX metrics for rolling fraud rates, merchant anomaly scores, customer average transaction values, and velocity trends.

---

## 📂 Repository Structure

```text
bank-fraud-detection-dwh/
├── sql/
│   ├── schema_and_stored_procedures.sql  # Complete DDL, Views, Stored Procedures, Triggers & Functions
│   └── sample_data.sql                   # Lightweight seed dataset for testing and demonstration
├── bi/
│   ├── screenshots/                      # Power BI Dashboard visuals and report exports
│   └── README.md                         # Notes on Power BI data modeling and DAX measures
├── .gitignore                            # Excludes massive database dumps (>100MB) and binary files
└── README.md
```

---

## 🚀 Quickstart Guide

### 1. Initialize the Database
Open MySQL Workbench or your MySQL 8.0 CLI terminal:

```sql
-- 1. Create database and load schema + stored procedures
SOURCE sql/schema_and_stored_procedures.sql;

-- 2. Load seed sample data
SOURCE sql/sample_data.sql;
```

### 2. Test Fraud Detection Procedures
```sql
USE `transactions`;

-- Inspect suspicious customer transactions
SELECT * FROM suspicious_transactions_by_customer LIMIT 10;

-- Trigger automated fraud detection routine for a transaction
CALL detect_transactions(1001);
```

### 3. Power BI Reporting
- Open Power BI Desktop and connect to your local MySQL instance (Database: `transactions`).
- *Note:* Due to GitHub's 100MB file limit, the full 255MB `.pbix` file with complete history can be downloaded via Google Drive [Add Link Here], or loaded directly using the provided SQL schema.

---

## 👤 Author
- **Linh Chi** (Hanoi University of Science and Technology - HUST)
- Email: [thlchi071005@gmail.com]
