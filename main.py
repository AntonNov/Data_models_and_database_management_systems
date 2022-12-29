import psycopg2
from config import *

try:
    connection = psycopg2.connect(
        host = host,
        user = user,
        password = password,
        database = db_name
    )
    with connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT * FROM _user
            """)
        print(cursor.fetchall())

except Exception as _ex:
    print("[INFO] Error while working with PostgreSQL\n", _ex)

finally:
    if connection:
        connection.close()
        print("[INFO] PostgreSQL connection closed")
