DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA IF NOT EXISTS public;

CREATE TABLE IF NOT EXISTS _user ( 
  id    SERIAL PRIMARY KEY,
  name  VARCHAR(30) NOT NULL ,
  phone CHAR(9) NOT NULL,
  points  INT NOT NULL
);

CREATE TABLE IF NOT EXISTS _order ( 
  id  SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES _user (Id),
  time  TIME NOT NULL,
  total_sum INT NOT NULL
);

CREATE TABLE IF NOT EXISTS menu_item ( 
  id SERIAL PRIMARY KEY,
  name  VARCHAR(50) NOT NULL ,
  description  VARCHAR(300) NOT NULL,
  calories  INT NOT NULL,
  price INT NOT NULL
);

CREATE TABLE IF NOT EXISTS order_menu_item ( 
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL,
  menu_item_id  INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES _order (Id),
  FOREIGN KEY (menu_item_id) REFERENCES menu_item (Id),
  amount  INT NOT NULL
);
CREATE TABLE IF NOT EXISTS menu ( 
  id  SERIAL PRIMARY KEY,
  name  VARCHAR(50) NOT NULL ,
  description VARCHAR(300) NOT NULL,
  menu_start_time  TIME NOT NULL,
  menu_end_time  TIME NOT NULL
);

CREATE TABLE IF NOT EXISTS menu_menu_item (  
    menu_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    FOREIGN KEY (menu_id)  REFERENCES menu (Id),
    FOREIGN KEY (menu_item_id)  REFERENCES menu_item (Id)
);
CREATE TYPE product_type AS ENUM ('coffee', 'dessert');

CREATE TABLE IF NOT EXISTS _type ( 
  id  SERIAL PRIMARY KEY,
  name  product_type NOT NULL
);

CREATE TABLE IF NOT EXISTS product ( 
  id  SERIAL PRIMARY KEY,
  name  VARCHAR(50) NOT NULL ,
  description  VARCHAR(300) NOT NULL,
  type_id INT NOT NULL,
  FOREIGN KEY (type_id) REFERENCES _type (Id),
  origin_country  VARCHAR(30) NOT NULL,
  price_in_kg INT NOT NULL
);

CREATE TABLE IF NOT EXISTS menu_item_product (  
    product_id    INT NOT NULL,
    menu_item_id INT NOT NULL,
    FOREIGN KEY (product_id)  REFERENCES product (Id),
    FOREIGN KEY (menu_item_id)  REFERENCES menu_item (Id)
);