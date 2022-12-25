INSERT INTO _user (name, phone, points)
VALUES
('Тамара', '295852715', 1000),
('Анатолий', '446540272', 100),
('Антон', '445350763', 2000),
('Анна', '292281408', 5000),
('Вероника', '291408228', 500);

INSERT INTO _order (user_id, time, total_sum)
VALUES
(1, '2022-12-24 05:02:20', 5),
(2, '2022-12-24 13:14:42', 18),
(3, '2022-12-24 13:18:42', 3),
(4, '2022-12-24 17:04:40', 12),
(5, '2022-12-24 21:03:30', 10);

INSERT INTO menu_item (name, food_type, description, weight, calories, price)
VALUES
('капучино', 'coffee', 'Кофейный напиток итальянской кухни на основе эспрессо
 с добавлением в него подогретого вспененного молока', 300, 120, 3),
('латте', 'coffee', 'Для приготовления латте на три части молока берётся одна часть эспрессо.
Молоко взбивается в пену, но более воздушную и менее упругую, чем в капучино,
  а затем выливается в кофе', 300, 250,  3),
('красный бархат', 'dessert','Шоколадный торт тёмно-красного, ярко-красного или красно-коричневого цвета.
 Традиционно готовится как слоёный пирог с глазурью из сливочного сыра', 110, 393, 4),
('морковный торт', 'dessert', 'Торт, содержащий морковь, смешанную с тестом. 
Тёртая морковь смягчается в процессе приготовления, а торт, как правило, имеет мягкую, плотную текстуру. 
Морковь улучшает вкус, текстуру и внешний вид торта', 100, 450, 4),
('шварцвальд', 'dessert', 'Торт со взбитыми сливками и вишней', 100, 300, 4);

INSERT INTO order_menu_item (name, menu_item_id, amount)
VALUES
(1, 1, 3),
(2, 2, 4),
(3, 3, 5),
(4, 4, 1),
(5, 5, 1);




