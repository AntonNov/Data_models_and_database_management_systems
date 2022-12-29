import psycopg2
from MyEnums import *
import config

while True:
    try:
        connection = psycopg2.connect(
            host=config.host, user=config.user, password=config.password, database=config.db_name
        )
        connection.autocommit = True   

        ROLE = int(input("Выберите вашу роль\n0 - BARISTA\n1 - USER:\n 2 - ADMIN:"))
        name, phone = '', ''

        if ROLE == Role.USER: 
            USER_CHOICE = int(input("Регистрация, вход, изменение данных, удаление? 0/1/2/3: "))
            phone = input("Введите номер телефона в формате (25/29/44/33)XXXXXXX: ")
            if phone[:2] not in ('25', '29', '44', '33'):
                    raise Exception('Неверный формат телефона для пользователей Беларуси')
            if USER_CHOICE == UserChoice.REGISTRATION:
                name = input("Введите ваше имя: ")
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
                with connection.cursor() as cursor:
                    cursor.execute(
                        f"""
                            SELECT name, points FROM _user
                            WHERE phone='{phone}';
                            """
                    )
                    user_data = cursor.fetchone()
                    if user_data is None:
                        raise Exception('Вы не зарегистрированы')
                    name, points = user_data
            elif USER_CHOICE == UserChoice.UPDATE:
                ch = int(input(
                    '''what do you want to update?
                        0 - name,
                        1 - phone,
                        2 - both
                    '''))
                
                if ch == ChoiceInUpdate.NAME:
                    new_name = input("Введите новое имя: ")
                    with connection.cursor() as cursor:
                        cursor.execute(
                            f"""
                                UPDATE _user
                                SET name = '{new_name}'
                                WHERE phone='{phone}';
                                """
                        )
                elif ch == ChoiceInUpdate.PHONE:
                    new_phone = input("Введите номер телефона в формате (25/29/44/33)XXXXXXX: ")
                    with connection.cursor() as cursor:
                        cursor.execute(
                            f"""
                                UPDATE _user
                                SET phone = '{new_phone}'
                                WHERE phone='{phone}';
                                """
                        )
                elif ch == ChoiceInUpdate.BOTH:
                    new_name = input("Введите новое имя: ")
                    new_phone = input("Введите номер телефона в формате (25/29/44/33)XXXXXXX: ")
                    with connection.cursor() as cursor:
                        cursor.execute(
                            f"""
                                UPDATE _user
                                SET phone = '{phone}, name = '{name}'
                                WHERE phone='{phone}';
                                """
                        )
                with connection.cursor() as cursor:
                    cursor.execute(
                        f"""
                            SELECT name, points FROM _user
                            WHERE phone='{phone}';
                            """
                    )
                    user_data = cursor.fetchone()
                    if user_data is None:
                        raise Exception('Вы не зарегистрированы')
                    name, points = user_data
            elif USER_CHOICE == UserChoice.DELETE:    
                with connection.cursor() as cursor:
                    cursor.execute(
                        f"""
                            DELETE FROM _user
                            WHERE phone='{phone}';
                            """
                    )
                with connection.cursor() as cursor:
                    cursor.execute(
                    f"""
                        SELECT name, points FROM _user
                        WHERE phone='{phone}';
                        """
                    )
                user_data = cursor.fetchone()
                if user_data is None:
                    raise Exception('Вы не зарегистрированы')
                name, points = user_data

            print(f"Вы {name}, ваши баллы {points}")

        elif ROLE == Role.BARISTA:
            print('Приступаем к работе!!!\n')
            print('Добро пожаловать в Cofix!!!')
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

        elif ROLE == Role.ADMIN:
            password_for_admin = input('Введите пароль администратора')
            if password_for_admin != config.password_for_admin:
                raise Exception('Отказано в доступе. Введите пароль администратора')
            else:
                print('What do you want to do?')

    except Exception as _ex:
        print("[INFO]", _ex)

    finally:
        if connection:
            connection.close()
            print("[INFO] PostgreSQL connection closed")