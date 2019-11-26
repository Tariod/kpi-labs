from .random_algoritm import random_algoritm
from .resource import Resource
from .scheduler import Scheduler
from .stdin import StandardInput
from .stdout import StandardOutput


class System:
    def __init__(
        self,
        intensity=0.5,
        max_complexity=4,
        end_time=100,
        algorithm=False
    ):
        self._scheduler = Scheduler(Resource(), random_algoritm)
        self._stdin = StandardInput(intensity, max_complexity, end_time)
        self._stdout = StandardOutput()
        self._time = 0
        self._stdout._history = []

    def tick(self):
        bids = self._stdin.tick(self._time)
        res = self._scheduler.tick(self._time, *bids)
        if res is not None:
            self._stdout.echo(res)
        self._time += 1

    def run(self, naeb=False):
        while self._stdin.is_not_empty() or not self._scheduler.is_free():
            self.tick()
        if naeb:
            self._stdout.smooth()

    def statistics(self):
        return self._stdout.history(), self._scheduler.monitoring()
