CREATE FUNCTION user_points_check() RETURNS trigger AS $$
    BEGIN
        -- Откуда такие баллы?
        IF NEW.points > 10000 THEN
            RAISE EXCEPTION 'Where do these scores come from?';
        END IF;
        RETURN NEW;
    END;

$$ LANGUAGE plpgsql;


CREATE TRIGGER user_points_check BEFORE INSERT OR UPDATE ON _user
    FOR EACH ROW EXECUTE PROCEDURE user_points_check();

-- INSERT INTO _user (name, phone, points)
-- VALUES
-- ('Владислав', '333333333', 50000)

-----------------------------------------------------------
CREATE FUNCTION user_name_check() RETURNS trigger AS $$
    BEGIN
    -- Владислав Сергеевич?
        IF NEW.name = 'Владислав' THEN
            RAISE EXCEPTION 'Владислав Сергеевич, не отчисляйте, пожалуйста :(';
        END IF;
        RETURN NEW;
    END;

$$ LANGUAGE plpgsql;


CREATE TRIGGER user_name_check BEFORE INSERT OR UPDATE ON _user
    FOR EACH ROW EXECUTE PROCEDURE user_name_check();

-----------------------------------------------------------

create table user_logging(
    id SERIAL not null,
    name VARCHAR(30),
    phone VARCHAR(9),
    points INT,
	action VARCHAR(30)
);

CREATE OR REPLACE FUNCTION insert_user_logging() RETURNS TRIGGER 
    AS $$
BEGIN
    INSERT INTO user_logging
    VALUES 
    (NEW.id, NEW.name, NEW.phone, NEW.points, 'insert');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE trigger insert_user_trigger
    AFTER INSERT ON _user
    FOR EACH ROW EXECUTE PROCEDURE insert_user_logging();

-----------------------------------------------------------
CREATE OR REPLACE FUNCTION delete_user_logging() RETURNS TRIGGER 
    AS $$
BEGIN
    INSERT INTO user_logging
    VALUES 
    (OLD.id, OLD.name,  OLD.phone, OLD.points, 'delete');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE trigger delete_user_trigger
    AFTER DELETE ON _user
    FOR EACH ROW EXECUTE PROCEDURE delete_user_logging();
-----------------------------------------------------------


-- CREATE OR REPLACE FUNCTION update_user_logging1() RETURNS TRIGGER 
--     AS $$
-- BEGIN
--     insert into user_logging
--     values (old.id, old.name, old.phone, old.points, 'update-был');
--     RETURN OLD;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE trigger update_user_trigger1
--     BEFORE UPDATE ON _user
--     FOR EACH ROW EXECUTE PROCEDURE update_user_logging1();

-- CREATE OR REPLACE FUNCTION update_user_logging2() RETURNS TRIGGER 
--     AS $$
-- BEGIN
--     insert into user_logging
--     values (new.id, new.name, new.phone, new.points, 'update-стал');
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE trigger update_user_trigger2
--     AFTER UPDATE ON _user
--     FOR EACH ROW EXECUTE PROCEDURE update_user_logging2();

-----------------------------------------------------------

CREATE OR REPLACE FUNCTION update_order_time() RETURNS TRIGGER AS $$
BEGIN
    UPDATE _order
    SET time = now()
    WHERE _order.id = NEW.order_id;
 
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE trigger update_order_time
    BEFORE INSERT ON order_menu_item
    FOR EACH ROW EXECUTE PROCEDURE update_order_time();

----------------------------------------------------------
-- CREATE OR REPLACE FUNCTION update_total_price() RETURNS TRIGGER 
--     AS $$
-- BEGIN
--  update _order
--  set total_sum = total_sum + new.amount - old.amount
--  where _order.id = new.order_id;
 
--  RETURN new;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE trigger update_total_price
--     BEFORE UPDATE ON order_menu_item
--     FOR EACH ROW EXECUTE PROCEDURE update_total_price();