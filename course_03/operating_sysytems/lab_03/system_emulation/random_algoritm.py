from random import randrange


def random_algoritm(queue):
    length = len(queue)
    if length > 0:
        return randrange(length)
