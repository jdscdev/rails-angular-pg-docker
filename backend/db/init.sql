CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  price NUMERIC
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  product_id INTEGER REFERENCES products(id),
  quantity INTEGER,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
