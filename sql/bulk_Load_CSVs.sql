CREATE DATABASE IF NOT EXISTS bike_store;
USE bike_store;

-- Production
CREATE TABLE IF NOT EXISTS brands (
  brand_id   INT PRIMARY KEY,
  brand_name VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS categories (
  category_id   INT PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS products (
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(255) NOT NULL,
  brand_id     INT NOT NULL,
  category_id  INT NOT NULL,
  model_year   SMALLINT NOT NULL,
  list_price   DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_products_brand     FOREIGN KEY (brand_id)    REFERENCES brands(brand_id),
  CONSTRAINT fk_products_category  FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sales
CREATE TABLE IF NOT EXISTS stores (
  store_id   INT PRIMARY KEY,
  store_name VARCHAR(255) NOT NULL,
  phone      VARCHAR(25),
  email      VARCHAR(255),
  street     VARCHAR(255),
  city       VARCHAR(50),
  state      VARCHAR(25),
  zip_code   VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS staffs (
  staff_id   INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name  VARCHAR(50) NOT NULL,
  email      VARCHAR(255),
  phone      VARCHAR(25),
  active     TINYINT(1) NOT NULL,
  store_id   INT NOT NULL,
  manager_id INT NULL,
  CONSTRAINT fk_staff_store   FOREIGN KEY (store_id)  REFERENCES stores(store_id),
  CONSTRAINT fk_staff_manager FOREIGN KEY (manager_id) REFERENCES staffs(staff_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS customers (
  customer_id INT PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  phone       VARCHAR(25),
  email       VARCHAR(255),
  street      VARCHAR(255),
  city        VARCHAR(50),
  state       VARCHAR(25),
  zip_code    VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS orders (
  order_id      INT PRIMARY KEY,
  customer_id   INT NOT NULL,
  order_status  TINYINT NOT NULL,
  order_date    DATE NOT NULL,
  required_date DATE NOT NULL,
  shipped_date  DATE NULL,
  store_id      INT NOT NULL,
  staff_id      INT NOT NULL,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_orders_store    FOREIGN KEY (store_id)    REFERENCES stores(store_id),
  CONSTRAINT fk_orders_staff    FOREIGN KEY (staff_id)    REFERENCES staffs(staff_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS order_items (
  order_id   INT NOT NULL,
  item_id    INT NOT NULL,
  product_id INT NOT NULL,
  quantity   INT NOT NULL,
  list_price DECIMAL(10,2) NOT NULL,
  discount   DECIMAL(4,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (order_id, item_id),
  CONSTRAINT fk_order_items_order   FOREIGN KEY (order_id)   REFERENCES orders(order_id) ON DELETE CASCADE,
  CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stocks (
  store_id   INT NOT NULL,
  product_id INT NOT NULL,
  quantity   INT NOT NULL DEFAULT 0,
  PRIMARY KEY (store_id, product_id),
  CONSTRAINT fk_stocks_store   FOREIGN KEY (store_id)   REFERENCES stores(store_id),
  CONSTRAINT fk_stocks_product FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bulk load CSVs (requires --local-infile=1 on the client)
LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/brands.csv'
INTO TABLE brands
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(brand_id, brand_name);

LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/categories.csv'
INTO TABLE categories
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(category_id, category_name);

LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(product_id, product_name, brand_id, category_id, model_year, list_price);

LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/stores.csv'
INTO TABLE stores
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(store_id, store_name, @phone, @email, @street, @city, @state, @zip_code)
SET phone = NULLIF(TRIM(@phone),'NULL'),
    email = NULLIF(TRIM(@email),'NULL'),
    street = TRIM(@street),
    city = TRIM(@city),
    state = TRIM(@state),
    zip_code = TRIM(@zip_code);

LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/staffs.csv'
INTO TABLE staffs
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(staff_id, first_name, last_name, @email, @phone, @active, store_id, @manager_id)
SET email = NULLIF(TRIM(@email),'NULL'),
    phone = NULLIF(TRIM(@phone),'NULL'),
    active = CAST(@active AS UNSIGNED),
    manager_id = NULLIF(TRIM(@manager_id),'NULL');

LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(customer_id, first_name, last_name, @phone, @email, @street, @city, @state, @zip_code)
SET phone = NULLIF(TRIM(@phone),'NULL'),
    email = NULLIF(TRIM(@email),'NULL'),
    street = TRIM(@street),
    city = TRIM(@city),
    state = TRIM(@state),
    zip_code = TRIM(@zip_code);


LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/stocks.csv'
INTO TABLE stocks
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(store_id, product_id, quantity);


LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@order_id,@customer_id,@order_status,@order_date,@required_date,@shipped_date,@store_id,@staff_id)
SET order_id      = CAST(TRIM(@order_id) AS UNSIGNED),
    customer_id   = CAST(TRIM(@customer_id) AS UNSIGNED),
    order_status  = CAST(TRIM(@order_status) AS UNSIGNED),
    order_date    = STR_TO_DATE(NULLIF(TRIM(@order_date),''),'%Y-%m-%d'),
    required_date = STR_TO_DATE(NULLIF(TRIM(@required_date),''),'%Y-%m-%d'),
    shipped_date  = STR_TO_DATE(NULLIF(TRIM(@shipped_date),''),'%Y-%m-%d'),
    store_id      = CAST(TRIM(@store_id) AS UNSIGNED),
    staff_id      = CAST(TRIM(@staff_id) AS UNSIGNED);

LOAD DATA LOCAL INFILE '/Users/kevinlee/Downloads/demo_playground/data/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@order_id,@item_id,@product_id,@quantity,@list_price,@discount)
SET order_id   = CAST(TRIM(@order_id) AS UNSIGNED),
    item_id    = CAST(TRIM(@item_id) AS UNSIGNED),
    product_id = CAST(TRIM(@product_id) AS UNSIGNED),
    quantity   = CAST(TRIM(@quantity) AS UNSIGNED),
    list_price = CAST(TRIM(@list_price) AS DECIMAL(10,2)),
    discount   = CAST(TRIM(@discount) AS DECIMAL(4,2));
