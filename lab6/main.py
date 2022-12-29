import psycopg2
from classes import *
from config import *

while True:
    try:
        connection = psycopg2.connect(
            host=host, user=user, password=password, database=db_name
        )
        connection.autocommit = True   

        ROLE = int(input("Выберите вашу роль\n0 - BARISTA\n1 - USER: "))
        name, phone = '', ''

        if ROLE == Role.USER: 
            USER_CHOICE = int(input("Регистрация или вход? 0/1: "))
            if USER_CHOICE == UserChoice.REGISTRATION:
                name = input("Введите ваше имя: ")
                phone = input("Введите номер телефона в формате (25/29/44/33)XXXXXXX: ")
                if phone[:2] not in ('25', '29', '44', '33'):
                    raise Exception('Неверный формат телефона для пользователей Беларуси')
                with connection.cursor() as cursor:
                    cursor.execute(
                        f"""
                        INSERT INTO _user (name, phone)
                        VALUES
                        ('{name}', '{phone}');
                        """
                    )
                    cursor.execute(
                        f"""
                            SELECT name, points FROM _user
                            WHERE phone='{phone}';
                            """
                    )
                    name, points = cursor.fetchone()     
            elif USER_CHOICE == UserChoice.LOGIN:
                phone = input("Введите номер телефона в формате (29/44)XXXXXXX: ")
                if phone[:2] not in ('29', '44', '33'):
                    raise Exception('Неверный формат телефона')
                with connection.cursor() as cursor:
                    cursor.execute(
                        f"""
                            SELECT name, points FROM _user
                            WHERE phone='{phone}';
                            """
                    )
                    temp = cursor.fetchone()
                    if temp is None:
                        raise Exception('Вы не зарегистрированы')
                    name, points = temp

            print(f"Вы {name}, ваши баллы {points}")

        elif ROLE == Role.BARISTA:
            print('Приступаем к работе!!!\n')
            with connection.cursor() as cursor:
                cursor.execute('''
                SELECT _user.name, menu_item.name, amount  FROM 
                (
                    (
                        (
                        _user JOIN _order ON _user.id = _order.user_id
                        )
                            JOIN order_menu_item ON _order.id = order_menu_item.order_id
                    )
                    JOIN menu_item ON menu_item.id = order_menu_item.menu_item_id
                )
                ''')
                for order_menu_item in cursor.fetchall():
                    user_name, menu_item, amount = order_menu_item
                    print(f'{menu_item} для {user_name} в количестве {amount} ')


    except Exception as _ex:
        print("[INFO]", _ex)

    finally:
        if connection:
            connection.close()
            print("[INFO] PostgreSQL connection closed")