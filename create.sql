DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA IF NOT EXISTS public;

CREATE TABLE _user ( 
  id  SERIAL PRIMARY KEY,
  name  VARCHAR(30) NOT NULL ,
  phone CHAR(9) NOT NULL,
  points  INT NOT NULL
);

CREATE TABLE _order ( 
  id  SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES _user (id),
  time  TIMESTAMP NOT NULL,
  total_sum INT NOT NULL
);

CREATE TYPE food_type AS ENUM ('coffee', 'dessert');

CREATE TABLE menu_item ( 
  id SERIAL PRIMARY KEY,
  name  VARCHAR(50) NOT NULL ,
  food_type food_type NOT NULL,
  description  VARCHAR(300) NOT NULL,
  weight INT NOT NULL,
  calories  INT NOT NULL,
  price INT NOT NULL
);

CREATE TABLE order_menu_item ( 
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL,
  menu_item_id  INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES _order (id),
  FOREIGN KEY (menu_item_id) REFERENCES menu_item (id),
  amount  INT NOT NULL
);

CREATE TABLE menu ( 
  id  SERIAL PRIMARY KEY,
  name  VARCHAR(50) NOT NULL ,
  description VARCHAR(300) NOT NULL,
  menu_start_time  TIMESTAMP NOT NULL,
  menu_end_time  TIMESTAMP NOT NULL
);

-- связь мгогие-ко-многим между menu и menu_item
CREATE TABLE menu_menu_item (  
    menu_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    FOREIGN KEY (menu_id)  REFERENCES menu (id),
    FOREIGN KEY (menu_item_id)  REFERENCES menu_item (id)
);

CREATE TABLE product ( 
  id  SERIAL PRIMARY KEY,
  name  VARCHAR(50) NOT NULL ,
  description  VARCHAR(300) NOT NULL,
  origin_country  VARCHAR(30) NOT NULL,
  price_in_kg INT NOT NULL
);

-- связь мгогие-ко-многим между menu_item и product
CREATE TABLE menu_item_product (  
    product_id    INT NOT NULL,
    menu_item_id INT NOT NULL,
    FOREIGN KEY (product_id)  REFERENCES product (id),
    FOREIGN KEY (menu_item_id)  REFERENCES menu_item (id)
);