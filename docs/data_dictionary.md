# Bike Store Database - Data Dictionary

## Overview
This document describes the database schema for the Bike Store demo database, including table structures, relationships, and data types.

## Database Schema

### Production Schema

#### brands
| Column    | Type        | Null | Key | Description                    |
|-----------|-------------|------|-----|--------------------------------|
| brand_id  | INT         | NO   | PK  | Unique identifier for brand    |
| brand_name| VARCHAR(255)| NO   |     | Name of the brand              |

#### categories
| Column      | Type        | Null | Key | Description                      |
|-------------|-------------|------|-----|----------------------------------|
| category_id | INT         | NO   | PK  | Unique identifier for category   |
| category_name| VARCHAR(255)| NO   |     | Name of the product category    |

#### products
| Column      | Type        | Null | Key | Description                      |
|-------------|-------------|------|-----|----------------------------------|
| product_id  | INT         | NO   | PK  | Unique identifier for product    |
| product_name| VARCHAR(255)| NO   |     | Name of the product              |
| brand_id    | INT         | NO   | FK  | Reference to brands.brand_id     |
| category_id | INT         | NO   | FK  | Reference to categories.category_id |
| model_year  | SMALLINT    | NO   |     | Year of the product model       |
| list_price  | DECIMAL(10,2)| NO   |     | Retail price of the product     |

#### stocks
| Column     | Type | Null | Key | Description                    |
|------------|------|------|-----|--------------------------------|
| store_id   | INT  | NO   | PK  | Reference to stores.store_id   |
| product_id | INT  | NO   | PK  | Reference to products.product_id |
| quantity   | INT  | NO   |     | Available quantity in stock    |

### Sales Schema

#### stores
| Column    | Type        | Null | Key | Description                    |
|-----------|-------------|------|-----|--------------------------------|
| store_id  | INT         | NO   | PK  | Unique identifier for store     |
| store_name| VARCHAR(255)| NO   |     | Name of the store               |
| phone     | VARCHAR(25) | YES  |     | Store phone number              |
| email     | VARCHAR(255)| YES  |     | Store email address             |
| street    | VARCHAR(255)| YES  |     | Store street address            |
| city      | VARCHAR(50) | YES  |     | Store city                      |
| state     | VARCHAR(25) | YES  |     | Store state                     |
| zip_code  | VARCHAR(10) | YES  |     | Store ZIP code                  |

#### staffs
| Column     | Type        | Null | Key | Description                    |
|------------|-------------|------|-----|--------------------------------|
| staff_id   | INT         | NO   | PK  | Unique identifier for staff     |
| first_name | VARCHAR(50) | NO   |     | Staff first name                |
| last_name  | VARCHAR(50) | NO   |     | Staff last name                 |
| email      | VARCHAR(255)| YES  |     | Staff email address             |
| phone      | VARCHAR(25) | YES  |     | Staff phone number              |
| active     | TINYINT(1)  | NO   |     | Whether staff is active (1/0)   |
| store_id   | INT         | NO   | FK  | Reference to stores.store_id   |
| manager_id | INT         | YES  | FK  | Reference to staffs.staff_id   |

#### customers
| Column     | Type        | Null | Key | Description                    |
|------------|-------------|------|-----|--------------------------------|
| customer_id| INT         | NO   | PK  | Unique identifier for customer  |
| first_name | VARCHAR(50) | NO   |     | Customer first name             |
| last_name  | VARCHAR(50) | NO   |     | Customer last name              |
| phone      | VARCHAR(25) | YES  |     | Customer phone number           |
| email      | VARCHAR(255)| YES  |     | Customer email address          |
| street     | VARCHAR(255)| YES  |     | Customer street address         |
| city       | VARCHAR(50) | YES  |     | Customer city                   |
| state      | VARCHAR(25) | YES  |     | Customer state                  |
| zip_code   | VARCHAR(10) | YES  |     | Customer ZIP code               |

#### orders
| Column       | Type        | Null | Key | Description                    |
|--------------|-------------|------|-----|--------------------------------|
| order_id     | INT         | NO   | PK  | Unique identifier for order     |
| customer_id  | INT         | NO   | FK  | Reference to customers.customer_id |
| order_status | TINYINT     | NO   |     | Order status (1-6)              |
| order_date   | DATE        | NO   |     | Date when order was placed      |
| required_date| DATE        | NO   |     | Required delivery date           |
| shipped_date | DATE        | YES  |     | Date when order was shipped     |
| store_id     | INT         | NO   | FK  | Reference to stores.store_id   |
| staff_id     | INT         | NO   | FK  | Reference to staffs.staff_id   |

#### order_items
| Column     | Type        | Null | Key | Description                    |
|------------|-------------|------|-----|--------------------------------|
| order_id   | INT         | NO   | PK  | Reference to orders.order_id   |
| item_id    | INT         | NO   | PK  | Line item identifier            |
| product_id | INT         | NO   | FK  | Reference to products.product_id |
| quantity   | INT         | NO   |     | Quantity ordered                |
| list_price | DECIMAL(10,2)| NO   |     | Unit price at time of order    |
| discount   | DECIMAL(4,2)| NO   |     | Discount applied (0.00-1.00)   |

## Relationships

### Foreign Key Constraints

1. **products.brand_id** → **brands.brand_id**
2. **products.category_id** → **categories.category_id**
3. **stocks.store_id** → **stores.store_id**
4. **stocks.product_id** → **products.product_id**
5. **staffs.store_id** → **stores.store_id**
6. **staffs.manager_id** → **staffs.staff_id** (self-referencing)
7. **orders.customer_id** → **customers.customer_id**
8. **orders.store_id** → **stores.store_id**
9. **orders.staff_id** → **staffs.staff_id**
10. **order_items.order_id** → **orders.order_id**
11. **order_items.product_id** → **products.product_id**

### Cardinality

- **One-to-Many**: brands → products, categories → products, stores → staffs, stores → orders, stores → stocks, customers → orders, staffs → orders, products → order_items, products → stocks
- **Many-to-Many**: stores ↔ products (through stocks table)

## Data Types

- **INT**: Used for IDs and quantities
- **VARCHAR**: Variable-length strings for names, addresses, etc.
- **DECIMAL**: Fixed-point numbers for prices and discounts
- **DATE**: Date values for order dates
- **SMALLINT**: Small integers for years and status codes
- **TINYINT(1)**: Boolean values (0/1)

## Constraints

- **Primary Keys**: All tables have appropriate primary keys
- **Foreign Keys**: All relationships are enforced with foreign key constraints
- **Check Constraints**: Quantity must be non-negative, discount must be between 0 and 1
- **NOT NULL**: Required fields are marked as NOT NULL
- **Unique**: Composite primary keys where appropriate (stocks, order_items)
