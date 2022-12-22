DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA IF NOT EXISTS public;

CREATE TABLE IF NOT EXISTS _user ( 
  id                SERIAL NOT NULL,
  name    VARCHAR(30) NOT NULL ,
  phone    CHAR(10) NOT NULL,
  points    INT NOT NULL,
  CONSTRAINT "PK_user" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS _order ( 
  id                SERIAL NOT NULL,
  user_id   INT NOT NULL ,
  time    TIME NOT NULL,
  total_sum   INT NOT NULL,
  CONSTRAINT "PK_order" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS order_menu_item ( 
  id                SERIAL NOT NULL,
  _order_id  INT NOT NULL ,
  menu_item_id  INT NOT NULL ,
  amount   INT NOT NULL,
  CONSTRAINT "PK_order_menu_item" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS menu_item ( 
  id                SERIAL NOT NULL,
  name    VARCHAR(50) NOT NULL ,
  description  VARCHAR(300) NOT NULL,
  calories    INT NOT NULL,
  price    INT NOT NULL,
  CONSTRAINT "PK_menu_item" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS menu ( 
  id                SERIAL NOT NULL,
  name    VARCHAR(50) NOT NULL ,
  description  VARCHAR(300) NOT NULL,
  menu_start_time  TIME NOT NULL,
  menu_end_time  TIME NOT NULL,
  CONSTRAINT "PK_menu" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS product ( 
  id                SERIAL NOT NULL,
  name    VARCHAR(50) NOT NULL,
  description  VARCHAR(300) NOT NULL,
  type_id    INT NOT NULL,
  origin_country  VARCHAR(30) NOT NULL,
  price_in_kg   INT NOT NULL,
  CONSTRAINT "PK_product" PRIMARY KEY (id)
);

CREATE TYPE IF NOT exists product_type AS ENUM ('coffee', 'dessert');

CREATE TABLE IF NOT EXISTS _type ( 
  id            SERIAL NOT NULL,
  name    product_type NOT NULL,
  CONSTRAINT "PK_type" PRIMARY KEY (id)
);

ALTER TABLE _order
    ADD CONSTRAINT "fk_order_user"
        FOREIGN KEY ("user_id")
            REFERENCES _user (id) ON DELETE CASCADE;
           
ALTER TABLE order_menu_item
    ADD CONSTRAINT "fk_order_menu_item"
        FOREIGN KEY ("menu_item_id")
            REFERENCES menu_item (id) ON DELETE CASCADE;
           
ALTER TABLE product
    ADD CONSTRAINT "fk_product_type"
        FOREIGN KEY ("type_id")
            REFERENCES _type (id) ON DELETE CASCADE;
