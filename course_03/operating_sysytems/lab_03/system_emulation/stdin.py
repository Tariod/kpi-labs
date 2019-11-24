from random import randrange
from .bid import Bid


class StandardInput:
    _queue = []

    @staticmethod
    def _generate_bid(advent, max_complexity):
        complexity = randrange(1, max_complexity)
        return Bid(advent, complexity)

    def __init__(self, intensity, max_complexity, end_time):
        load = int(round(end_time * intensity))
        for _ in range(load):
            advent = randrange(end_time)
            bid = StandardInput._generate_bid(advent, max_complexity)
            self._queue.append(bid)

        self._queue.sort(key=lambda bid: bid.advent, reverse=True)

    def is_not_empty(self):
        return len(self._queue) > 0

    def tick(self, time):
        res = []
        while len(self._queue) > 0 and self._queue[-1].advent == time:
            res.append(self._queue.pop())

        return res
