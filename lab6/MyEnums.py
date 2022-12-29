from enum import IntEnum

class Role(IntEnum):
    BARISTA = 0
    USER = 1
    ADMIN = 2


class UserChoice(IntEnum):
    REGISTRATION = 0
    LOGIN = 1
    UPDATE = 2
    DELETE = 3

class ChoiceInUpdate(IntEnum):
    NAME = 0
    PHONE = 1
    BOTH = 2


