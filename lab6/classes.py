from enum import IntEnum

class Role(IntEnum):
    BARISTA = 0
    USER = 1


class UserChoice(IntEnum):
    REGISTRATION = 0
    LOGIN = 1