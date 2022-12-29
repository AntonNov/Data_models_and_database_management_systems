SELECT * FROM _user;

SELECT DISTINCT name FROM _user;

SELECT * FROM _user WHERE points > 1000;

SELECT * FROM _user WHERE points BETWEEN 100 AND 1000;

SELECT MAX(points) FROM _user;

SELECT MIN(points) FROM _user;

SELECT * FROM _user order by points DESC;

SELECT * FROM _order OFFSET 2 LIMIT 4;

SELECT * FROM menu_item WHERE menu_id IN ('2', '3', '6');

SELECT * FROM _order WHERE _order.user_id = (SELECT id FROM _user WHERE _user.name = 'Анна')

-- внутреннее соединение
SELECT * FROM _user JOIN _order ON _user.id = user_id;

-- OUTER JOIN или внешнее соединение позволяет возвратить все строки одной или двух таблиц, которые участвуют в соединении.
SELECT * FROM _user RIGHT JOIN _order ON _user.id = user_id;

SELECT *
FROM _order
WHERE total_sum > (SELECT AVG(total_sum) FROM _order);


SELECT _user.name, SUM(weight) FROM
(
  (
    (
    _user JOIN _order ON _user.id = user_id)
                JOIN order_menu_item ON order_menu_item.id = order_id

                )
                  JOIN menu_item ON menu_item.id = menu_item_id
)
 GROUP BY _user.name ;
